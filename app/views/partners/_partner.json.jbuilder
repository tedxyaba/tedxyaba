json.partner_name partner.name
json.partner_bio partner.bio
json.partner_link partner.link

if partner.logo.attached?
  json.logo_url Rails.application.routes.url_helpers.url_for(partner.logo)
else
  json.logo_url nil
end
