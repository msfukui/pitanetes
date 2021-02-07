# pitanetes

A server configuration of msfukui's personal kubernetes cluster by raspberry pi.

## Setup

```
$ bundle config --local path vendor/bundle
$ bundle install
Fetching gem metadata from https://rubygems.org/.....
Resolving dependencies...
...
Bundle complete! 1 Gemfile dependency, 12 gems now installed.
Bundled gems are installed into `./vendor/bundle`
```

## Hosts

```
192.168.10.191 framy
192.168.10.192 spotty
192.168.10.193 painty
```

## Apply servers

```
$ bundle exec itamae ssh -h framy -u ubuntu -j nodes/framy.json roles/default.rb
 INFO : Starting Itamae...
 INFO : Loading node data from /Users/msfukui/projects/pitanetes/nodes/framy.json...
"os_version": { "platform": "ubuntu", "version": "20.04", "hostname": "ubuntu"}
 INFO : Recipe: /Users/msfukui/projects/pitanetes/roles/default.rb
 INFO :   Recipe: /Users/msfukui/projects/pitanetes/recipes/print_os_version/default.rb
 INFO :   Recipe: /Users/msfukui/projects/pitanetes/recipes/set_ssh_public_keys/default.rb
```
