# frozen_string_literal: true

execute 'package upgrade all' do
  command 'sudo apt update && sudo apt upgrade --yes'
end
