# frozen_string_literal: false

execute "delete default user's password" do
  command "sudo passwd -d #{node[:host][:user]}"
end
