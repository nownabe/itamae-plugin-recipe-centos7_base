describe package("yum-cron") do
  it { should be_installed }
end

describe service("yum-cron") do
  it { should be_enabled }
  it { should be_running }
end

describe file("/etc/yum/yum-cron.conf") do
  it { should be_file }
  its(:content) { should match /^apply_updates = yes$/ }
end
