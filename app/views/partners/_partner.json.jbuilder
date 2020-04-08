json.partner_name partner.name

if partner.logo.attached?
  json.logo_url url_for(partner.logo)
else
  json.logo_url nil
end
