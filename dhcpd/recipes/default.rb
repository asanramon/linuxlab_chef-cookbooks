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