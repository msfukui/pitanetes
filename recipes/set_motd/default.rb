# frozen_string_literal: true

remote_file '/etc/default/motd-news' do
  action :create
  path '/etc/default/motd-news'
  source './files/etc/default/motd-news'
  mode '644'
  owner 'root'
  group 'root'
end

remote_file '/etc/update-motd.d/00-header' do
  action :create
  path '/etc/update-motd.d/00-header'
  source './files/etc/update-motd.d/00-header'
  mode '755'
  owner 'root'
  group 'root'
end

remote_file '/etc/update-motd.d/10-help-text' do
  action :create
  path '/etc/update-motd.d/10-help-text'
  source './files/etc/update-motd.d/10-help-text'
  mode '755'
  owner 'root'
  group 'root'
end

remote_file '/etc/update-motd.d/99-welcome' do
  action :create
  path '/etc/update-motd.d/99-welcome'
  source './files/etc/update-motd.d/99-welcome'
  mode '755'
  owner 'root'
  group 'root'
end
