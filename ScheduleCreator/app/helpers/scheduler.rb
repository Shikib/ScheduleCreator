# A Strategy model for the act of obtaining an optimal schedule list
# that satisfies everything in the RequiredCourses table
module Scheduler
  # given a list of time_blocks, sorts them by start_time
  # outputs sorted list of time_blocks
  def quicksort_timeblocks(time_blocks)
    pivot = time_blocks[lo]
    left = []
    right = []

    time_blocks[1..time_blocks.size-1].each do |tb|
      if (tb.start_time < time_blocks[pivot].start_time)
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
      if (time_blocks[i].end_time > time_blocks[i+1].start_time)
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

  # main scheduling method.
  # takes RequiredCourse.all (later will be RequiredCourse.where(user: User))
  # outputs list of time_blocks.
  def schedule
    # obtain list of required courses
    course_titles = RequiredCourse.all

    # obtains Courses associated with each of these titles
    courses = []
    course_titles.each do |ct|
      courses.push(Course.where(subject: Subject.where(department: ct.department, courseId: ct.courseId)).first)
    end




  end
end
