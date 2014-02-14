#
# Cookbook Name:: base
# Recipe:: ntp
#
# Copyright 2014, ASRNet.com
#
# All rights reserved - Do Not Redistribute
#
package "ntp"

template "/etc/ntp.conf" do
	source "ntp.conf.erb"
	notifies :restart, "service[ntpd]"
end

service "ntpd" do
	action [:enable,:start]
end