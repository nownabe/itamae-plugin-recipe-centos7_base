execute "disable selinux" do
  command "setenforce 0"
  only_if "getenforce | grep -q 'Enforcing'"
end

remote_file "/etc/selinux/config" do
  source File.expand_path("../remote_files/selinux", __FILE__)
end
