#
# Cookbook Name:: dhcpd
# Recipe:: default
#
# Copyright 2014, ASRNet
#
# All rights reserved - Do Not Redistribute
#
package "dhcp"

cookbook_file "/etc/dhcp/dhcpd.conf" do
	source "dhcpd.conf"
	notifies :restart, "service[dhcpd]"
end

service "dhcpd" do
	action [:enable,:start]
end

hosts = data_bag('dhcp_hosts')
hosts.each do |item|
	host = data_bag_item('dhcp_hosts',item)
	puts host['id']
	puts host['hostname']
	puts host['mac_address']
	puts host['ip_address']
end
