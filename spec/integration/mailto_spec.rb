describe file("/etc/aliases") do
  it { should be_file }
  its(:content) { should match /^root\: hogehoge@foobar\.com$/ }
end

