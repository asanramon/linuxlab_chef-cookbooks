#
# Cookbook Name:: ntpd
# Recipe:: default
#
# Copyright 2014, ASRNet
# All rights reserved - Do Not Redistribute
#
package "ntp"

template "/etc/ntp.conf" do
	source "ntp.conf.erb"
	notifies :restart,"service[ntpd]"
end

template "/etc/sysconfig/iptables" do
	source "iptables.erb"
	notifies :restart,"service[iptables]"
end

service "ntpd" do
	action [:enable,:start]
end

service "iptables" do
	action :nothing
end