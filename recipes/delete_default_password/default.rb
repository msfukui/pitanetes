# frozen_string_literal: true

execute "delete default user's password" do
  command "sudo passwd -d #{node[:host][:user]}"
end
