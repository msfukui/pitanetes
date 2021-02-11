# frozen_string_literal: true

include_recipe '../recipes/print_os_version'
include_recipe '../recipes/set_ssh_public_keys'
include_recipe '../recipes/delete_default_password'
include_recipe '../recipes/set_hostname'
include_recipe '../recipes/set_etc_hosts'
include_recipe '../recipes/set_sshd_config'
include_recipe '../recipes/set_timezone'
include_recipe '../recipes/enable_mdns'
