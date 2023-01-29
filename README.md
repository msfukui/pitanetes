# pitanetes

A server configuration of msfukui's personal kubernetes cluster by raspberry pi (Ubuntu 20.04 LTS 3, 64bit).

## Setup

```
$ bundle config --local path vendor/bundle
$ bundle install
Fetching gem metadata from https://rubygems.org/.....
Resolving dependencies...
...
Bundled gems are installed into `./vendor/bundle`
```

## Configuraion

### Hosts

Set the IP Address to fixed with the Wi-Fi router, etc.

See `nodes/[hostname].json` for the settings.

### Node

Prepare the file as `nodes/[hostname].json`.

example:

* control-plane node

    ```
    {
      "host": {
        "name": "framy",
        "user": "ubuntu",
        "ip": "192.168.10.191",
        "timezone": "Asia/Tokyo",
        "master": true,
        "role": "pitanetes:master"
      },
      "etc": {
        "hosts": [
          { "name": "framy", "ip": "192.168.10.191" },
          { "name": "spotty", "ip": "192.168.10.192" },
          { "name": "painty", "ip": "192.168.10.193" },
          { "name": "msfukui.page", "ip": "192.168.10.240" }
        ]
      },
      "metallb": {
        "loadbalancer_ip_range": "192.168.10.240-192.168.10.250"
      },
      "recipes": [
        "base.rb",
        "master.rb"
      ]
    }
    ```

* worker node

    ```
    {
      "host": {
        "name": "spotty",
        "user": "ubuntu",
        "ip": "192.168.10.192",
        "timezone": "Asia/Tokyo",
        "master": false,
        "role": "pitanetes:worker"
      },
      "recipes": [
        "base.rb",
        "worker.rb"
      ]
    }
    ```

### Secret keys

#### mackerel api key

```
$ bundle exec itamae-secrets set --base=./secrets mackerel_apikey ********
```

### Note

* MetalLB's IPs

    Use the IPs from `192.168.10.240` to `192.168.10.250` for the MetalLB Layer 2 configuration.

* NGINX Ingress Controller's IP

    Borrow the IP `192.168.10.240` from MetalLB.

## Apply

### control-plane node

```
./bin/master_setup
...
```

dry-run:

```
./bin/master_setup --dry-run
...
```

### Worker node(s)

```
./bin/worker_setup
...
```

dry-run:

```
./bin/worker_setup --dry-run
...
```

## Recipe etc

### Test

Wether the command `itamae` a works:

```
$ bundle exec itamae ssh -l warn -u ubuntu -h framy -j nodes/framy.json recipes/test/default.rb
"host_inventory":
{
  "platform": "ubuntu",
  "platform_version": "20.04",
  "hostname": "framy"
}
"node":
{
  "host": {
    "name": "framy",
    "user": "ubuntu"
  }
}
```

### Display `kubeadm join` information for worker node(s)

After setting up the master node:

```
$ bundle exec itamae ssh -l warn -h framy -u ubuntu -j nodes/framy.json recipes/get_kubeadm_join/default.rb 
{
  "token": "xxxx.*********",
  "hash": "********",
  "ip": "***.***.***.***",
  "port": "****"
}
```

### Set ddclient for Dynamic DNS (Google Domains)

Set username and password in advance by the following method.

```
$ bundle exec itamae-secrets set --base=./secrets ddclient_username ********
$ bundle exec itamae-secrets set --base=./secrets ddclient_password ********
```

Moreover:

```
$ bundle exec itamae ssh -u ubuntu -h framy -j nodes/framy.json recipes/package_ddclient/default.rb
 INFO : Starting Itamae...
 INFO : Loading node data from /Users/msfukui/projects/pitanetes/nodes/framy.json...
 INFO : Recipe: /Users/msfukui/projects/pitanetes/recipes/package_ddclient/default.rb
 INFO :   package[ddclient] installed will change from 'false' to 'true'
 INFO :   template[/etc/ddclient.conf] modified will change from 'false' to 'true'
 ...
 INFO :   Notifying restart to service resource 'ddclient' (delayed)
 INFO :   (because it subscribes this resource)
 INFO :   remote_file[/etc/default/ddclient] modified will change from 'false' to 'true'
 ...
 INFO :   Notifying restart to service resource 'ddclient' (delayed)
 INFO :   (because it subscribes this resource)
```

### Deploy `ingress-nginx` and TLS certificate

Deploy the Ingress(use `NGINX Ingress Controller`) and TLS terminations on `msfukui.page` with the following command:

```
$ kubectl apply -f manifests/cert-manager/msfukui.issuer.yml 
issuer.cert-manager.io/msfukui-letsencrypt-production created
$ kubectl get issuer
NAME                             READY   AGE
msfukui-letsencrypt-production   True    37m
```

```
$ kubectl apply -f manifests/ingress/msfukui.ingress.yml 
ingress.networking.k8s.io/msfukui-ingress created
$ kubectl get ingress
NAME              CLASS    HOSTS          ADDRESS          PORTS     AGE
msfukui-ingress   <none>   msfukui.page   192.168.10.193   80, 443   49m
$ kubectl get services -n ingress-nginx
NAME                                 TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)                      AGE
ingress-nginx-controller             LoadBalancer   10.109.101.82   192.168.10.240   80:31760/TCP,443:30423/TCP   6d10h
ingress-nginx-controller-admission   ClusterIP      10.98.166.150   <none>           443/TCP                      6d10h

```

## Feature

* automate firmware settings and reboot

* migrate from itamae to mitamae & hocho

* test code with `serverspec`

...

## Reference

### itamae

* itamae

    https://github.com/itamae-kitchen/itamae

* mitamae

    https://github.com/itamae-kitchen/mitamae

* hocho

    https://github.com/sorah/hocho

* itamae-secrets

    https://github.com/sorah/itamae-secrets

* サーバーのプロビジョニングをmitamae + hochoでやる方法 - Qiita

    https://qiita.com/k0kubun/items/f6a5ccc649a25fc61351

* Chef脱落者が、Itamaeで快適インフラ生活する話 - Qiita

    https://qiita.com/zaru/items/8ae6182e544aac6f6d79

* ようやく itamae の使い方が固まってきたのでメモ - えいのうにっき

    https://blog.a-know.me/entry/2018/01/24/221051

* マネーフォワードのItamae Tips

    https://moneyforward.com/engineers_blog/2017/04/11/itamae-tips/

* itamae実践Tips - Qiita

    https://qiita.com/sue445/items/b67b0e7209a7fae1a52a

### Raspberry Pie

* 自宅にKubernetesクラスター『おうちKubernetes』を作ってみた

    https://eng-blog.iij.ad.jp/archives/6304

    この記事がきっかけで環境を作る気持ちになりました。

* Raspberry Pi 4にUbuntu 20.04 LTSとDockerをインストールする - Qiita

    https://qiita.com/yuyakato/items/ff7b23f9cee42c937ba9

* GPIO - Raspberry Pie Documentation

    https://www.raspberrypi.org/documentation/usage/gpio/

    ピンの意味からわかっていなかったので、ラックのファンの配線を指す際の参考になりました。

* ラズパイkubernetes構築メモ

    https://blog.tsuchinokometal.com/2021/raspberrypi_k8s/

    構築タイミングや対象OSが近くて参考になりました。

* Raspbian初期設定(RaspberryPi4)

    https://qiita.com/legitwhiz/items/bc897259b27f3c0e7aa0

    Raspbian は結局使わなかったですが、config の記述が参考になります。

### Docker, Kubanetes

* Install Docker Engine on Ubuntu | docker docs

    https://docs.docker.com/engine/install/ubuntu/

* Container runtimes | Kubernetes

    https://kubernetes.io/docs/setup/production-environment/container-runtimes/

* Installing kubeadm | Kubernetes

    https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

    日本語のドキュメントにある「iptablesがnftablesバックエンドを使用しないようにする」という記載 (https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#iptables%E3%81%8Cnftables%E3%83%90%E3%83%83%E3%82%AF%E3%82%A8%E3%83%B3%E3%83%89%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%97%E3%81%AA%E3%81%84%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B) は 1.17 以降では不要な対応みたいです。

    英語版からは該当の記述は削除されていました。(2021-02-11 現在)

    c.f. http://otake.knowd2.com/drupal-rotake/?q=node/203

* Kubernetesの Service についてまとめてみた - Qiita

    https://qiita.com/kouares/items/94a073baed9dffe86ea0

* k8sのノードをアップデートする - Qiita

    https://qiita.com/murata-tomohide/items/19ce618bc4e431954f5b

* kubeadm のアップグレード | Kubernetes

    https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-upgrade/

* kubeadmのトラブルシューティング | Kubernetes

    https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/troubleshooting-kubeadm/

* RaspberryPi上のkubernetes(kubeadm)をアップグレード

    https://qiita.com/yasthon/items/10239c8b70bf19055e2d

* kubernetesのコンテナランタイムをdockerからcontainerdに変更する

    https://qiita.com/yasthon/items/31c1870d2fd2d6dd864a

* Network Plugins | Kubernetes

    https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/

    v1.24 にアップグレードした際,  --network-plugin オプションが廃止されていて kubelet が起動しなかったので, /var/lib/kubelet/kubeadm-flags.env を編集して該当の記載を削除しました。

### flannel

https://github.com/flannel-io/flannel

flannel のリポジトリはパスが変更になっていました。(古いパスからもリダイレクトされます)

2023年1月現在の最新版の v0.20.2 は起動に失敗したため一旦 v0.16.3 で動作させています。

### MetalLB

https://metallb.universe.tf

* MetalLB installation

    https://metallb.universe.tf/installation/

* MetalLB configuration

    https://metallb.universe.tf/configuration/

### NGINX Ingress Controller

https://kubernetes.github.io/

* Installation Guide - Bare-metal

    https://kubernetes.github.io/ingress-nginx/deploy/#bare-metal

* Bare-metal considerations

    https://kubernetes.github.io/ingress-nginx/deploy/baremetal/

* templates/controller-service.yaml

    https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/templates/controller-service.yaml

* Kubernetes + cert-manager + letsencrypt + ingress-nginx-controller環境構築 - Qiita

    https://qiita.com/iqustechtips/items/1ec6b32a98b3fab427d6

### cert-manager

https://cert-manager.io

* Installation / Kubernetes

    https://cert-manager.io/docs/installation/kubernetes/

* Tutorials / Securing NGINX-ingress

    https://cert-manager.io/docs/tutorials/acme/ingress/

* Configuration / ACME

    https://cert-manager.io/docs/configuration/acme/

*  FAQ / Troubleshooting Issuing ACME Certificates

    https://cert-manager.io/docs/faq/acme/

### Observation

* mackerel

    https://mackerel.io

### Dynamic DNS

* ダイナミック DNS - Google Domains ヘルプ

    https://support.google.com/domains/answer/6147083?hl=ja&ref_topic=9018335

* ddclientでGoogle DomainsのDDNSを更新する方法

    https://www.uchidigi.com/2020/01/ddclient-google-ddns.html

### CoreDNS

* CoreDNS Manual

    https://coredns.io/manual/toc/

    ログは設定するとデフォルトでは標準出力される、など。

* Docker によるDNS サーバーのデプロイ - vertual pantry

    https://blog.vpantry.net/2020/04/coredns/

    コンテナで DNS を提供したかったので参考にさせていただきました。

* Ubuntu: How To Free Up Port 53, Used By systemd-resolved

    https://www.linuxuprising.com/2020/07/ubuntu-how-to-free-up-port-53-used-by.html

    設定変更後、サーバを再起動したくなかったので、その箇所を除いて参考にしました。

* Ubuntu18.04のDNSリゾルバをsystemd-resolvedからdnsmasqに変更する - ぶていのログでぶログ

    https://tech.buty4649.net/entry/2018/10/13/130045

    `sudo systemctl restart systemd-resolved` で systemd-resolved を再起動するところだけを参考にしました。
