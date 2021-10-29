# frozen_string_literal: true

execute 'package repogitories update' do
  command 'sudo apt update -y'
end

execute 'package dist-upgrade' do
  command 'sudo apt dist-upgrade -y'
end

execute 'package autoremove' do
  command 'sudo apt autoremove -y'
end

execute 'package autoclean' do
  command 'sudo apt autoclean'
end
