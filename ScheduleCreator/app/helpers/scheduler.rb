# A Strategy model for the act of obtaining an optimal schedule list
# that satisfies everything in the RequiredCourses table
module Scheduler
  # given two days of the week, determine if a comes before b
  def before_in_week(a,b)
    days = %w(Sun Mon Tue Wed Thu Fri Sat)
    return days.index(a) < days.index(b)
  end

  # given a list of time_blocks, sorts them by start_time
  # outputs sorted list of time_blocks
  def quicksort_timeblocks(time_blocks)
    if (time_blocks.size <= 1)
      return time_blocks
    end

    pivot = time_blocks[0]
    left = []
    right = []

    time_blocks[1..time_blocks.size-1].each do |tb|
      if (tb.term.to_i < pivot.term.to_i)
        left.push(tb)
      elsif (pivot.term.to_i < tb.term.to_i)
        right.push(tb)
      elsif (before_in_week(tb.day, pivot.day))
        left.push(tb)
      elsif (before_in_week(pivot.day, tb.day))
        right.push(tb)
      elsif (tb.start_time < pivot.start_time)
        left.push(tb)
      else
        right.push(tb)
      end
    end

    sorted_left = quicksort_timeblocks(left)
    sorted_right = quicksort_timeblocks(right)
    time_blocks = sorted_left.push(pivot) + sorted_right
    return time_blocks
  end

  # given a sorted list of time_blocks, determines if there is any
  # overlap between consecutive time_blocks
  def exists_overlap?(time_blocks)
    (0..time_blocks.size - 2).each do |i|
      if (time_blocks[i].term == time_blocks[i+1].term &&
          time_blocks[i].day == time_blocks[i+1].day &&
          time_blocks[i].end_time > time_blocks[i+1].start_time)
        return true
      end
    end
    return false
  end

  # takes in a list of time_blocks and determines
  # if there is any overlap between them.
  # problem could have been solved in O(n) using a hash,
  # but in the interest of space, it's being solved in O(nlogn)
  # where n is most likely less than 20 for reasonable inputs
  def valid_schedule?(time_blocks)
    time_blocks = quicksort_timeblocks(time_blocks)
    return !exists_overlap?(time_blocks)
  end

  # checks to see if the time_blocks satisfy the requirements of the course
  def requirement_satisfied?(time_blocks, course)
    lecture_satisfied = false
    lab_satisfied = !course.lab_required # if lab isn't required, it's satisfied immediately
    tutorial_satisfied = !course.tutorial_required
    time_blocks.each do |tb|
      if (tb.section.course == course)
        if (tb.section_type == 'LectureSection')
          lecture_satisfied = true
        elsif (tb.section_type == 'LabSection')
          lab_satisfied = true
        elsif (tb.section_type == 'TutorialSection')
          tutorial_satisfied = true
        end
      end
    end
    return lecture_satisfied && lab_satisfied && tutorial_satisfied
  end

  # takes in a list of time_blocks and a list of required courses
  # as input and determines whether all of the required courses
  # have been satisfied and ensures no additional courses were added
  def complete_schedule?(time_blocks, courses)
    # check to see that all course requirements have been satisfied
    # this part is more likely to return false than the next part
    courses.each do |course|
      if (!requirement_satisfied?(time_blocks, course))
        return false
      end
    end

    # check to see that we haven't added any unnecessary courses
    # this is more of an error check, rather than something that we
    # expect to ever be false
    time_blocks.each do |tb|
      course = tb.section.course
      if (!courses.include? course)
        # we added an unnecessary section
        return false
      end
    end
  end

  # given a list of required courses, a list of scheduled sections, a list of timeblocks
  # computes the optimal schedule. this method ignores the fact that labs/tutorials exist
  # and only schedules lectures
  def schedule_courses(courses, scheduled_sections, time_blocks)
    if (!valid_schedule?(time_blocks))
      return false
    end

    if (courses.empty?)
      return time_blocks
    end

    course_required = courses.pop
    LectureSection.where(course: course_required).each do |lec|
      new_schedule = scheduled_sections.dup.push(lec)
      try = schedule_courses(courses, new_schedule, time_blocks + TimeBlock.where(section: lec))
      if (!try)
        return try
      end
    end

    return false
  end

  # main scheduling method.
  # takes RequiredCourse.all (later will be RequiredCourse.where(user: User))
  # outputs list of time_blocks.
  def schedule
    # obtain list of required courses
    course_titles = RequiredCourse.all

    # obtains Courses associated with each of these titles
    courses = []
    course_titles.each do |ct|
      courses.push(Course.where(subject: Subject.where(department: ct.department), courseId: ct.courseId).first)
    end

    return schedule_courses(courses, [], [])


  end
end
