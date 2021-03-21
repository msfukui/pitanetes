# frozen_string_literal: true

include_recipe '../recipes/set_kubeadm_for_master'
include_recipe '../recipes/set_manifest_flannel'
include_recipe '../recipes/set_manifest_metallb'
include_recipe '../recipes/set_manifest_ingress-nginx'
include_recipe '../recipes/set_manifest_cert-manager'
# include_recipe '../recipes/package_ddclient/default.rb'
