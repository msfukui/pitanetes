# frozen_string_literal: true

execute 'package upgrade all' do
  command 'sudo apt update -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean'
end
