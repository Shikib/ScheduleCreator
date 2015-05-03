json.array!(@required_courses) do |required_course|
  json.extract! required_course, :id
  json.url required_course_url(required_course, format: :json)
end
