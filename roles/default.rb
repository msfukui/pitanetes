# frozen_string_literal: true

include_recipe '../recipes/set_ssh_public_keys'
include_recipe '../recipes/delete_default_password'
include_recipe '../recipes/set_hostname'
include_recipe '../recipes/set_motd'
include_recipe '../recipes/set_etc_hosts'
include_recipe '../recipes/set_sshd_config'
include_recipe '../recipes/set_timezone'
include_recipe '../recipes/set_ntp_server'
include_recipe '../recipes/package_upgrade_all'
include_recipe '../recipes/enable_mdns'
include_recipe '../recipes/package_docker'
include_recipe '../recipes/set_docker'
include_recipe '../recipes/package_kubernetes'
include_recipe '../recipes/set_kubeadm_for_master'
include_recipe '../recipes/set_flannel'
