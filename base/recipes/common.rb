#
# Cookbook Name:: base
# Recipe:: common
#
# Copyright 2014, ASRNet.com
#
# All rights reserved - Do Not Redistribute
#

template "/etc/yum.repos.d/linuxlab.repo" do
	source "linuxlab.repo.erb"
end

cookbook_file "/etc/pki/tls/certs/repo.crt" do
	source "ca.crt"
end

ruby_block "set_repo_cert" do
	block do
		file = Chef::Util::FileEdit.new("/etc/yum.conf")
		file.insert_line_if_no_match("^sslcacert = .*$", 'sslcacert = /etc/pki/tls/certs/repo.crt')
		file.write_file
	end
end

package "openssh-clients"
package "tcpdump"
package "bind-utils"

chef_gem "ruby-shadow" do
	action :install
end

# Create user accounts
users = data_bag('linuxlab_users')
users.each do |item|
	user_item = data_bag_item('linuxlab_users', item)
	user user_item['username'] do
		comment user_item['comment']
		home user_item['home']
		shell user_item['shell']
		password user_item['password']
		supports :manage_home => true
	end
end

# Create admins accounts
admins = data_bag('linuxlab_admins')
admins.each do |item|
	admin = data_bag_item('linuxlab_admins', item)
	user admin['username'] do
		comment admin['comment']
		home admin['home']
		shell admin['shell']
		password admin['password']
		supports :manage_home => true
	end
end

# Create admins group account
group "admins" do
	members admins
end

# Create auto logoff script
template "/etc/profile.d/autologoff.sh" do
	source "autologoff.sh.erb"
end

cookbook_file "/etc/sudoers.d/sudo_admins" do
	source "sudo_admins"
	owner "root"
end

ruby_block "rename default repo" do
	block do
		if ::File.file?("/etc/yum.repos.d/CentOS-Base.repo")
			::File.rename("/etc/yum.repos.d/CentOS-Base.repo","/etc/yum.repos.d/CentOS-Base.repo.orig")
		end
	end
end

cron "chef-run" do
	command "chef-client > /tmp/chef-run.log"
	user "root"
	hour "6"
end

template "/etc/sysconfig/iptables" do
	source "iptables.erb"
	notifies :restart,"service[iptables]"
end

service "iptables" do
	action :nothing
end