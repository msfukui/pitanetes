# frozen_string_literal: false

execute "set timezone #{node[:host][:timezone]}" do
  command "sudo timedatectl set-timezone #{node[:host][:timezone]}"
end
