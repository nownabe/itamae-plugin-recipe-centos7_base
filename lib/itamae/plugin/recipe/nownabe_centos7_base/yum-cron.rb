package "yum-cron"

service "yum-cron" do
  action [:start, :enable]
end
