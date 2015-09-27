# centos7-base
An itamae plugin for CentOS 7.x

## Installation
Add this line to your application's Gemfile:

```ruby
gem "itamae-plugin-recipe-centos7_base", github: "nownabe/itamae-plugin-recipe-centos7_base"
```

And then execute:

    $ bundle

## Recipes
* disable_selinux
* enable_wheel
* epel
* mailto
* sshd_config
* users
* yum-cron

## Usage
### Include Recipes
When using all recipes, in your recipe:

```ruby
include_recipe "centos7_base"
```

When only selected recipes, in your recipe:

```ruby
include_recipe "centos7_base::users"
```

## Recipes
### users
#### configuration
```yaml
base:
  users:
    YOUR_USER_NAME:
      github_user: YOUR_GITHUB_USER # using fetch ssh public keys from github
      groups: wheel
      password: HASHED_PASSWORD # you can use itamae:mkpasswd task
```

### mailto
#### configuration
```yaml
base:
  mailto:
    root: your@email.addr
```

## Rake Tasks
You can use some support tasks.
In your Rakefile:

```ruby
require "itamae/centos7_base_tasks"
```

Tasks:

```bash
$ bundle exec rake -T
rake itamae:mkpasswd # Make password hash (SHA-512)
```

## Contributing

1. Fork it ( https://github.com/nownabe/itamae-plugin-recipe-centos7_base/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
