# frozen_string_literal: true

%w[
  binutils
  build-essential
  sysstat
].each do |p|
  package p do
    action :install
  end
end
