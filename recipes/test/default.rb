# frozen_string_literal: true

# c.f. https://serverspec.org/host_inventory.html

p_host_inventory = {}
p_host_inventory[:platform] = node[:platform]
p_host_inventory[:platform_version] = node[:platform_version]
p_host_inventory[:hostname] = node[:hostname]

puts '"host_inventory": '
puts JSON.pretty_generate(p_host_inventory)

p_node = {}
p_node[:host] = {}
p_node[:host][:name] = node[:host][:name]
p_node[:host][:user] = node[:host][:user]

puts '"node": '
puts JSON.pretty_generate(p_node)
