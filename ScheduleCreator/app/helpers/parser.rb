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

  # for CPSC in 2015S you would call get_subject_uri('2015', 'S', 'CPSC')
  def get_subject_uri(year, session, dept)
    uri = 'https://courses.students.ubc.ca/cs/main?'
    uri += 'sessyr=' + year + '&'
    uri += 'sesscd=' + session +'&'
    uri += 'pname=subjarea&tname=subjareas&req=1&dept=' + dept + '&'
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
  end

end
