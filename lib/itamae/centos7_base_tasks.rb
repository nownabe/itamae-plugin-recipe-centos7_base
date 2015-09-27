require "io/console"
require "unix_crypt"

module Itamae
  module Centos7Base
    SALT_CHARSET =
      "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    SALT_LENGTH = 8

    def self.salt
      SALT_LENGTH.times.inject("") do |s, _|
        s << SALT_CHARSET[rand(SALT_CHARSET.size)]
      end
    end
  end
end

namespace :itamae do
  desc "Make password hash (SHA-512)"
  task :mkpasswd do
    print "password: "
    pass = STDIN.noecho(&:gets).chomp
    puts

    puts UnixCrypt::SHA512.build(pass, Itamae::Centos7Base.salt)
  end
end
