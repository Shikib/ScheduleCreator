json.array!(@lecture_sections) do |lecture_section|
  json.extract! lecture_section, :id
  json.url lecture_section_url(lecture_section, format: :json)
end
