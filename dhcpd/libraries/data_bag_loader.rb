module DataBagLoader
	def self.load_dhcp_hosts
		hash_hosts = {}
		hosts = Chef::DataBag.load('dhcp_hosts')
		hosts.each do |item|
			host = Chef::DataBagItem.load('dhcp_hosts',item[0])
			hash_hosts.store(host['id'], {:hostname => host['hostname'], :mac_address => host['mac_address'], :ip_address => host['ip_address']})
		end
		hash_hosts
	end
end