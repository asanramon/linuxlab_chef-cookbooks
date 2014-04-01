#
# Cookbook Name:: base
# Recipe:: reboot
#
# Copyright 2014, ASRNet
#
# All rights reserved - Do Not Redistribute
#
execute "first_run_reboot" do
	command <<-EOH
		rm -f "/tmp/first_run_reboot"
		reboot
	EOH
	only_if { ::File.exist?("/tmp/first_run_reboot") }
end