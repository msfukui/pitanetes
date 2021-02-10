# pitanetes

A server configuration of msfukui's personal kubernetes cluster by raspberry pi (Ubuntu 20.04 LTS 2, 64bit).

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

Set with Wi-Fi router, etc.

```
192.168.10.191 framy
192.168.10.192 spotty
192.168.10.193 painty
```

## Apply to servers

```
$ bundle exec itamae ssh -h framy -u ubuntu -j nodes/framy.json roles/default.rb
 INFO : Starting Itamae...
 INFO : Loading node data from /Users/msfukui/projects/pitanetes/nodes/framy.json...
"os_version": { "platform": "ubuntu", "version": "20.04", "hostname": "ubuntu"}
 INFO : Recipe: /Users/msfukui/projects/pitanetes/roles/default.rb
 INFO :   Recipe: /Users/msfukui/projects/pitanetes/recipes/print_os_version/default.rb
 INFO :   Recipe: /Users/msfukui/projects/pitanetes/recipes/set_ssh_public_keys/default.rb
```

## Reference

* itamae https://github.com/itamae-kitchen/itamae

* mitamae https://github.com/itamae-kitchen/mitamae

* hocho https://github.com/sorah/hocho

* サーバーのプロビジョニングをmitamae + hochoでやる方法 - Qiita https://qiita.com/k0kubun/items/f6a5ccc649a25fc61351

* Chef脱落者が、Itamaeで快適インフラ生活する話 - Qiita https://qiita.com/zaru/items/8ae6182e544aac6f6d79

* ようやく itamae の使い方が固まってきたのでメモ - えいのうにっき https://blog.a-know.me/entry/2018/01/24/221051

* マネーフォワードのItamae Tips https://moneyforward.com/engineers_blog/2017/04/11/itamae-tips/
