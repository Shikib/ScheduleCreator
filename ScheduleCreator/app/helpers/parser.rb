module Parser
  require 'open-uri'

  def parse_subject
    doc = Nokogiri::HTML(open("https://courses.students.ubc.ca/cs/main?pname=subjarea&tname=subjareas&req=1&dept=CPSC", {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))

    description = doc.at_css("p").to_s
    description = description.delete("<p>").delete("</p>").delete("\n").delete("\r")

    subject = Subject.new
    subject.description = description
    subject.save
  end

end
