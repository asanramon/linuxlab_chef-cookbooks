#
# Cookbook Name:: nas
# Recipe:: nfs
#
# Copyright 2014, ASRNet
#
# All rights reserved - Do Not Redistribute
#
package "nfs-utils"
package "nfs-utils-lib"

ruby_block "mount_repo_share" do
	block do
		file = Chef::Util::FileEdit.new("/etc/fstab")
		file.insert_line_if_no_match("^/dev/sdb1.*$", "/dev/sdb1\t\t\t\t\t/data\t\t\text4\tdefaults\t0 0")
		file.write_file
		`mount -a`
	end
end

cookbook_file "/etc/exports" do
	source "nfs/exports"
	notifies :restart, "service[nfs]"
end

cookbook_file "/etc/sysconfig/nfs" do
	source "nfs/nfs"
	notifies :restart, "service[nfs]"
end

service "nfs" do
	action [:enable,:start]
end
