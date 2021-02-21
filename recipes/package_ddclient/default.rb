# frozen_string_literal: true

# c.f. https://support.google.com/domains/answer/6147083?hl=ja&ref_topic=9018335

require 'itamae/secrets'
node[:secrets] = Itamae::Secrets(File.join(__dir__, '..', '..', 'secrets'))
username = node[:secrets][:ddclient_username]
password = node[:secrets][:ddclient_password]

if node[:host][:master]

  package 'ddclient' do
    action :install
  end

  template '/etc/ddclient.conf' do
    action :create
    path '/etc/ddclient.conf'
    source './templates/etc/ddclient.conf.erb'
    mode '600'
    owner 'root'
    group 'root'
    variables(username: username, password: password)
  end

  remote_file '/etc/default/ddclient' do
    action :create
    path '/etc/default/ddclient'
    source './files/etc/default/ddclient'
    mode '644'
    owner 'root'
    group 'root'
  end

  service 'ddclient' do
    action %i[start enable]
    subscribes :restart, 'template[/etc/ddclient.conf]'
    subscribes :restart, 'remote_file[/etc/default/ddclient]'
  end

end
