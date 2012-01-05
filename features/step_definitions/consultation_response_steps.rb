When /^I draft a new consultation response "([^"]*)" to the consultation "([^"]*)"$/ do |response_title, consultation_title|
  consultation = Consultation.find_by_title!(consultation_title)
  visit admin_consultation_path(id: consultation.id)
  click_link "Add response"
  fill_in "Title", with: response_title
  fill_in "Body", with: "First responder"
  click_button "Save"
end

When /^a submitted consultation response "([^"]*)" to the consultation "([^"]*)" exists$/ do |response_title, consultation_title|
  consultation = Consultation.find_by_title!(consultation_title)
  create(:submitted_consultation_response, title: response_title, consultation: consultation)
end

Then /^the consultation "([^"]*)" should show the response "([^"]*)"$/ do |consultation_title, response_title|
  consultation = Consultation.find_by_title!(consultation_title)
  visit consultation_path(consultation.document_identity)
  assert has_css?("a[href='#{consultation_response_path(consultation)}']", text: response_title)
end
