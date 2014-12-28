describe user("nownabe") do
  it { should be_exist }
  it { should belong_to_group "nownabe" }
  it { should belong_to_group "wheel" }
  it { should have_authorized_key File.read("#{Dir.home}/.ssh/id_rsa.pub") }
end


