# frozen_string_literal: true

# Set up to Crontab for User

user = node[:host][:user]

directory "/home/#{user}/conf/pitanetes/crontab" do
  action :create
  path "/home/#{user}/conf/pitanetes/crontab"
  mode '750'
  owner user
  group user
end

template "/home/#{user}/conf/pitanetes/crontab/crontab" do
  action :create
  path "/home/#{user}/conf/pitanetes/crontab/crontab"
  source './templates/conf/pitanetes/crontab/crontab.erb'
  mode '640'
  owner user
  group user
  variables(user: user)
end

execute 'Crontab setting' do
  command "crontab -u #{user} /home/#{user}/conf/pitanetes/crontab/crontab"
end
