package "openssh-server"

service "sshd" do
  action [:start, :enable]
end

remote_file "/etc/ssh/sshd_config" do
  source File.expand_path("../remote_files/sshd_config", __FILE__)
  owner "root"
  group "root"
  mode "0600"
  notifies :restart, "service[sshd]"
end
