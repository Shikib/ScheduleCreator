json.array!(@lab_sections) do |lab_section|
  json.extract! lab_section, :id
  json.url lab_section_url(lab_section, format: :json)
end
