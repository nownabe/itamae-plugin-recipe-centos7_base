keys_file = File.expand_path("../keys", __FILE__)
keys = File.read(keys_file).lines.map(&:chomp)

describe user("user01") do
  it { should be_exist }
  it { should belong_to_group "user01" }
  it { should belong_to_group "wheel" }
  keys.each do |key|
    it { should have_authorized_key key }
  end
end
