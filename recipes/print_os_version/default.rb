# frozen_string_literal: false

puts '"os_version": ' \
  << '{' \
  << " \"platform\": \"#{node[:platform]}\"," \
  << " \"version\": \"#{node[:platform_version]}\"," \
  << " \"hostname\": \"#{node[:hostname]}\"" \
  << '}'
