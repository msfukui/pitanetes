# frozen_string_literal: true

user = node[:host][:user]

execute "delete default user's password" do
  command "sudo passwd -d #{user}"
end
