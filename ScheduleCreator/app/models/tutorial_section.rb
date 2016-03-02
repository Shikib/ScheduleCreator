class TutorialSection < ActiveRecord::Base
  belongs_to  :lecture_section
  has_many    :time_blocks, :as => :section
end
