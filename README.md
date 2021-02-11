# pitanetes

A server configuration of msfukui's personal kubernetes cluster by raspberry pi (Ubuntu 20.04 LTS 2, 64bit).

## Setup

```
$ bundle config --local path vendor/bundle
$ bundle install
Fetching gem metadata from https://rubygems.org/.....
Resolving dependencies...
...
Bundled gems are installed into `./vendor/bundle`
```

## Hosts

Set with Wi-Fi router, etc.

```
192.168.10.191 framy  # master, control-plane
192.168.10.192 spotty # worker
192.168.10.193 painty # worker
```

## Apply

```
$ bundle exec itamae ssh -h framy -u ubuntu -j nodes/framy.json roles/default.rb
 INFO : Starting Itamae... 
 INFO : Loading node data from /Users/msfukui/projects/pitanetes/nodes/framy.json...
 INFO : Recipe: /Users/msfukui/projects/pitanetes/roles/default.rb
 INFO :   Recipe: /Users/msfukui/projects/pitanetes/recipes/set_ssh_public_keys/default.rb
 INFO :   Recipe: /Users/msfukui/projects/pitanetes/recipes/delete_default_password/default.rb
...
```

## Reference

### itamae

* itamae https://github.com/itamae-kitchen/itamae

* mitamae https://github.com/itamae-kitchen/mitamae

* hocho https://github.com/sorah/hocho

* サーバーのプロビジョニングをmitamae + hochoでやる方法 - Qiita https://qiita.com/k0kubun/items/f6a5ccc649a25fc61351

* Chef脱落者が、Itamaeで快適インフラ生活する話 - Qiita https://qiita.com/zaru/items/8ae6182e544aac6f6d79

* ようやく itamae の使い方が固まってきたのでメモ - えいのうにっき https://blog.a-know.me/entry/2018/01/24/221051

* マネーフォワードのItamae Tips https://moneyforward.com/engineers_blog/2017/04/11/itamae-tips/

* itamae実践Tips - Qiita https://qiita.com/sue445/items/b67b0e7209a7fae1a52a

### Raspberry Pie

* 自宅にKubernetesクラスター『おうちKubernetes』を作ってみた https://eng-blog.iij.ad.jp/archives/6304

    この記事がきっかけで環境を作る気持ちになりました。

* Raspberry Pi 4にUbuntu 20.04 LTSとDockerをインストールする - Qiit https://qiita.com/yuyakato/items/ff7b23f9cee42c937ba9

* GPIO - Raspberry Pie Documentation https://www.raspberrypi.org/documentation/usage/gpio/

    ピンの意味からわかっていなかったので、ラックのファンの配線を指す際の参考になりました。

### Docker, Kubanetes

* Install Docker Engine on Ubuntu | docker docs https://docs.docker.com/engine/install/ubuntu/

* Container runtimes | Kubernetes https://kubernetes.io/docs/setup/production-environment/container-runtimes/

* Installing kubeadm | Kubernetes https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

    日本語のドキュメントにある「iptablesがnftablesバックエンドを使用しないようにする」という記載 (https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#iptables%E3%81%8Cnftables%E3%83%90%E3%83%83%E3%82%AF%E3%82%A8%E3%83%B3%E3%83%89%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%97%E3%81%AA%E3%81%84%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B) は 1.17 以降では不要な対応みたいです。

    c.f. http://otake.knowd2.com/drupal-rotake/?q=node/203

    英語版からは該当の記述は削除されていました。(2021-02-11)

* flannel https://github.com/coreos/flannel
