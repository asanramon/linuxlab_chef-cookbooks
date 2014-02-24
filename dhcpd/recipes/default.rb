#
# Cookbook Name:: dhcpd
# Recipe:: default
#
# Copyright 2014, ASRNet
#
# All rights reserved - Do Not Redistribute
#
package "dhcp"

template "/etc/dhcp/dhcpd.conf" do
	source "dhcpd.conf.erb"
	notifies :restart,"service[dhcpd]"
end

service "dhcpd" do
	action [:enable,:start]
end
