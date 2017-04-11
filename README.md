Zabbix NTP servers monitoring template
=====================================

This repo contains everything you need to discover and monitor your NTP time servers in the [Zabbix](http://zabbix.com) open-source monitoring platform. 
This Template use peers information from local ntpd time server, wich must be installed on Zabbix sever or on its Agent. 
This Template supports Zabbix's powerful discovery and it will allow you automatically add new time servers to monitoring its states. To do it you need only add new peer to local time server and restart it. 
This Template has triggers, wich will send notification messages when monitored time server stratum (time precision level) will be more than 4. 

> [NTP](http://www.ntp.org/) is a protocol designed to synchronize the clocks of computers over a network.

### Latest / Change log

* [03/01/2017]: The first version of this Template was published.

### Requirements

* Zabbix Server >= 3.x (tested on 3.2 only)
* Zabbix Frontend >= 3.x
* NTPd >= 4.2
* perl >= 5

### Install Instruction

* Usually local time server may be installed on Zabbix server or any Zabbix Agent server. By example to install NTP server on Linux Centos 6/7 you need to run this command:
`sudo yum -y install ntp`
* Also you need install `perl` by command `sudo yum -y install perl`
* Place all files from this repo to the same directories.
* Change ip addresses of NTP servers in `ntpd.conf` file.
* Make NTPd service as autostarted by command: 
    `sudo chkconfig ntpd on` on Centos 6 Linux or
    `sudo systemctl enable ntpd` on Centos 7 Linux
* Start NTPd service by command `service ntpd start`
* Check that the local time server has connections to its peers by command:
    `ntpq -n -c peers localhost`
* Restart Zabbix-agent server by command `service zabbix-agent restart`
* Import to Zabbix server `zbx_ntp_peers_template.xml` template file and add this template to Zabbix server host.


### License

[GNU GPL v3 License] (https://www.gnu.org/licenses/gpl.html)
