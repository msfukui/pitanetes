# frozen_string_literal: true

execute "set hostname #{node[:host][:name]}" do
  command "sudo hostnamectl set-hostname #{node[:host][:name]}"
end
