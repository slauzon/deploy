Reach3 docker deployment
========================

Requirements
============

* A linux server with accessible IP address (public) able to run Docker version at least 1.9.0 (any modern would fit)
* A domain name resolving to this IP address that will serve as an UI entrance point and a SIP domain
* Installed git

Notes
=====

Setup procedure will try to automatically detect the external IP address.

Installation
============

Execute as root:

```sh
yum -y install git
git clone https://github.com/swarmcom/deploy
cd deploy
./rhel-host-setup.sh
```

Then login as user ezuce, and do:

```sh
git clone https://github.com/swarmcom/deploy
cd deploy
./run.sh DOMAIN
```
