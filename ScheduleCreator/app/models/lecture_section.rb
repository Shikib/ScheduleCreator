class LectureSection < ActiveRecord::Base
  belongs_to  :course
  has_many    :tutorial_sections
  has_many    :lab_sections
  has_many    :time_blocks, :as => :section
end
