When(/^click the link for the latest email alerts$/) do
  within '.feeds' do
    click_on 'email'
  end
end

Then(/^I should see email signup information for "(.*?)"$/) do |_organisation_name|
  assert(page.has_link?("MHRA's alerts and recalls for drugs and medical devices", href: "/drug-device-alerts/email-signup"))
  assert(page.has_link?("Drug Safety Update", href: "/drug-safety-update/email-signup"))
  assert(page.has_link?("MHRA's new publications, statistics, consultations and announcements",
                        href: "/government/email-signup/new?email_signup%5Bfeed%5D=https%3A%2F%2Fwww.gov.uk%2Fgovernment%2Forganisations%2Fmedicines-and-healthcare-products-regulatory-agency.atom"))
end
