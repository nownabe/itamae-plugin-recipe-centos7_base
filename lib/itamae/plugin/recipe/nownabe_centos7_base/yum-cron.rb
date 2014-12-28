package "yum-cron"

service "yum-cron" do
  action [:start, :enable]
end

remote_file "/etc/yum/yum-cron.conf" do
  source File.expand_path("../remote_files/yum-cron.conf", __FILE__)
end

