require "io/console"
require "unix_crypt"

SALT_CHARSET = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

namespace :itamae do
  desc "Make password hash (SHA-512)"
  task :mkpasswd do
    print "password: "
    pass = STDIN.noecho(&:gets).chomp
    puts

    salt = (0..7).inject(""){ |s,i| s << SALT_CHARSET[rand(64)] }
    puts UnixCrypt::SHA512.build(pass, salt)
  end
end
