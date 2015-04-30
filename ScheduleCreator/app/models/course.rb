class Course < ActiveRecord::Base
  belongs_to  :subject
  has_many    :lab_sections
  has_many    :tutorial_sections
  has_many    :lecture_sections
end
