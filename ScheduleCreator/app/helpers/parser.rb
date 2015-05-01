# This parser will need to be changed if UBC ever updates the HTML code
# for their parsing method. Unfortunately there's no way of getting around this.

module Parser
  require 'open-uri'

  # assume default year has been set somewhere else
  def set_term(year, session)
    @year = year
    @session = session
  end

  # returns false iff requested subject/course/section is not offered
  def is_valid(message)
    message.sub('course', 'subject').sub('section','subject')
    if (message.include? 'The requested subject is either no longer offered at UBC Vancouver or is not being offered this session.')
      return false
    end
    return true
  end

  def get_base_uri(year, session)
    uri = 'https://courses.students.ubc.ca/cs/main?'
    uri += 'sessyr=' + year + '&'
    uri += 'sesscd=' + session +'&'
    uri += 'pname=subjarea&tname=subjareas&req=0&'
  end

  # for CPSC in 2015S you would call get_subject_uri('2015', 'S', 'CPSC')
  def get_subject_uri(year, session, dept)
    uri = get_base_uri(year, session).sub('req=0', 'req=1')
    uri += 'dept=' + dept + '&'
  end

  # for CPSC 110 in 2015S you would call get_course_uri('2015', 'S', 'CPSC', '110')
  def get_course_uri(year, session, dept, courseId)
    uri = get_subject_uri(year, session, dept).sub('req=1','req=3')
    uri += 'course=' + courseId + '&'
  end

  # for CPSC 110 911 in 2015S you would call get_section_uri('2015', 'S', 'CPSC', '110', '911')
  def get_section_uri(year, session, dept, courseId, sectionId)
    uri = get_course_uri(year, session, dept, courseId).sub('req=3','req=5')
    uri += 'section=' + sectionId
  end

  def is_lecture_id?(sectionId)
    return sectionId[/[0-9]*/] == sectionId
  end

  def is_section_id?(sectionId)
    return sectionId.length < 6
  end

  def is_vantage_id?(sectionId)
    return sectionId[0] == 'V'
  end

  def is_waitlist_id?(sectionId)
    return sectionId[1] == 'W' || sectionId[1] == 'C'
  end

  def parse_non_lecture_section(dept, courseId, sectionId, lecture)
    uri = get_section_uri(@year, @session, dept, courseId, sectionId)
    doc = Nokogiri::HTML(open(uri, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))

    title = doc.at_css('h4').children.to_s
    section_type = title.split('(')[1][0...-1]
    if (section_type == 'Tutorial' || section_type == 'Discussion')
      section = TutorialSection.new
    else
      section = LabSection.new
    end
    section.lecture_section = lecture
    section.section_id = sectionId
    section.title = title.split(' (')[0]

    seats_block = doc.css('.table-nonfluid strong')
    if (seats_block.empty?)
      section.seats_remaining = 0
      section.currently_registered = 0
    else
      section.seats_remaining = seats_block[1].children.to_s.to_i
      section.currently_registered = seats_block[2].children.to_s.to_i
    end
    section.save
  end

  def parse_lecture_section(dept, courseId, sectionId, sections, course)
    uri = get_section_uri(@year, @session, dept, courseId, sectionId)
    doc = Nokogiri::HTML(open(uri, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))

    lecture = LectureSection.new
    lecture.course = course
    lecture.section_id = sectionId
    lecture.title = doc.at_css('h4').children.to_s.split(' (')[0]

    seats_block = doc.css('.table-nonfluid strong')
    if (seats_block.empty?)
      lecture.seats_remaining = 0
      lecture.currently_registered = 0
    else
      lecture.seats_remaining = seats_block[1].children.to_s.to_i
      lecture.currently_registered = seats_block[2].children.to_s.to_i
    end
    lecture.save

    sections.each do |s|
      parse_non_lecture_section(dept, courseId, s, lecture)
    end

    if (LabSection.where(lecture_section: lecture).size > 0)
      course.lab_required = course.lab_required || true
    else
      course.lab_required = course.lab_required || false
    end
    if (TutorialSection.where(lecture_section: lecture).size > 0)
      course.tutorial_required = course.tutorial_required || true
    else
      course.tutorial_required = course.tutorial_required || false
    end
    course.save
  end

  def parse_course(dept, courseId, subject)
    uri = get_course_uri(@year, @session, dept, courseId)
    doc = Nokogiri::HTML(open(uri, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))

    description = doc.at_css('p').to_s
    description = description.delete('<p>').delete('</p>').delete("\n").delete("\r")

    if (!is_valid(description))
      return false
    end

    course = Course.new
    course.subject = subject
    course.courseId = courseId
    course.title = doc.at_css('h4').child.to_s
    course.description = description

    credits = doc.css('p')[1].to_s
    course.credits = credits[credits.index(': ')+2].to_i
    # lab_required and tutorial_required are handled by section parsing
    course.save

    # parse sections
    lecture_id = ''
    sections = []
    doc.css('table tr a').each do |s|
      sectionId = s.children[0].to_s.split(' ')[2]
      if (is_lecture_id?(sectionId))
        if (lecture_id != '')
          parse_lecture_section(dept, courseId, lecture_id, sections, course)
        end
        lecture_id = sectionId
        sections = []
      elsif (is_section_id?(sectionId) && !is_waitlist_id?(sectionId) && !is_vantage_id?(sectionId))
        sections.push(sectionId)
      end
    end

    if (lecture_id != '')
      parse_lecture_section(dept, courseId, lecture_id, sections, course)
    end
  end

  def parse_subject(dept)
    uri = get_subject_uri(@year, @session, dept)
    doc = Nokogiri::HTML(open(uri, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))

    description = doc.at_css('p').to_s
    description = description.delete('<p>').delete('</p>').delete("\n").delete("\r")

    if (!is_valid(description))
      return false
    end

    subject = Subject.new
    subject.description = description
    subject.department = dept
    subject.year = @year
    subject.session = @session
    subject.save

    doc.css('#mainTable a').each do |t|
      parse_course(dept, t.children.to_s.split(' ')[1], subject)
    end
  end

  # will parse all the subjects/courses/lecture sections/lab sections offered in
  # specified term
  def parse_everything
    uri = get_base_uri(@year, @session)
    doc = Nokogiri::HTML(open(uri, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))
    doc.css('tr a').each do |sub|
      parse_subject(sub.children.to_s)
    end
  end

end
