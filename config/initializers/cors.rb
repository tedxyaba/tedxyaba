# Be sure to restart your server when you modify this file.

# Specify a serializer for the signed and encrypted cookie jars.
# Valid options are :json, :marshal, and :hybrid.
Rails.application.config.action_dispatch.cookies_serializer = :json

# Rails 6 has support for blocking requests from unknown hosts, so origin domains will need to be added there as well.
Rails.application.config.hosts << "tedxyaba.com"
Rails.application.config.hosts << "tedxyaba-web.herokuapp.com"
# will see how localhost works
# Rails.application.config.hosts << "tedxyaba.com"
