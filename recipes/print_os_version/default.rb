# frozen_string_literal: false

puts '"os_version": ' \
  << '{' \
  << " \"platform\": \"#{node[:platform]}\"," \
  << " \"version\": \"#{node[:platform_version]}\"," \
  << " \"hostname\": \"#{node[:hostname]}\"" \
  << ' }'

puts '"node": ' \
  << '{' \
  << ' "host": {' \
  << " \"name\": \"#{node[:host][:name]}\"," \
  << " \"user\": \"#{node[:host][:user]}\"" \
  << ' }' \
  << ' }'
