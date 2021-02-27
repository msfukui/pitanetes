# frozen_string_literal: true

include_recipe '../recipes/set_kubeadm_for_master'
include_recipe '../recipes/set_flannel'
include_recipe '../recipes/set_metallb'
# include_recipe '../recipes/package_ddclient/default.rb'
