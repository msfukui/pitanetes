# frozen_string_literal: false

execute "set hostname #{node[:host][:name]}" do
  command "sudo hostnamectl set-hostname #{node[:host][:name]}"
end
