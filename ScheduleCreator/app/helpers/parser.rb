module Parser
  require 'open-uri'

  def parse_subject
    uri  = open("https://courses.students.ubc.ca/cs/main?pname=subjarea&tname=subjareas&req=1&dept=CPSC", {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE})
    doc = Nokogiri::HTML(uri)
    sub = Subject.new
    sub.description = doc.at_css("p")
    sub.save
  end

end
