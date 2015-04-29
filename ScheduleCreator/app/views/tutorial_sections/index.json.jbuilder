json.array!(@tutorial_sections) do |tutorial_section|
  json.extract! tutorial_section, :id
  json.url tutorial_section_url(tutorial_section, format: :json)
end
