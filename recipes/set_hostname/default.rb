# frozen_string_literal: true

host = node[:host][:name]

execute "set hostname #{host}" do
  command "sudo hostnamectl set-hostname #{host}"
end
