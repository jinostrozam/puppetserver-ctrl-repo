#!/bin/bash
source /etc/lsb-release
wget https://apt.puppetlabs.com/puppet-release-${DISTRIB_CODENAME}.deb
dpkg -i puppet-release-${DISTRIB_CODENAME}.deb
apt-get update
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install puppet-agent
apt-get -y install git git-core curl zlib1g-dev build-essential gcc libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev gnupg rng-tools apt-transport-https zsh curl
apt-get install -y ntp ntpdate
ntpdate -u 0.ubuntu.pool.ntp.org
timedatectl set-timezone America/Santiago
locale-gen es_CL




