remote_file "/etc/pam.d/su" do
  source File.expand_path("../remote_files/su", __FILE__)
  owner "root"
  group "root"
  mode "0644"
end
