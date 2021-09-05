# frozen_string_literal: true

include_recipe '../recipes/set_kubeadm_for_worker'
include_recipe '../recipes/set_kube_node_worker_label'
include_recipe '../recipes/set_coredns'
