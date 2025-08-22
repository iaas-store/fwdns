## Windows Firewall Fule by DNS

Like MikroTik ROS address-list implementation, 
this script getting domain name from FW Rule DisplayName, resolving and put IP adresses to RemoteAdress.

This implementation allows centralized (DNS) management of IP access for unrelated Windows servers.  
To change the list of IP addresses, simply change them in the DNS control panel of your domain

### Requirements
- Global domain name
- Server / computer with Windows 10/Windows Server 2019+ (lower may work but not tested)
- Admin rights

### How to use
1. Create management subdomain on your domain, for example:
```shell
$ dig A mgt.example.com

;; QUESTION SECTION:
;mgt.example.com.         IN      A

;; ANSWER SECTION:
mgt.example.com.  5372    IN      A       2.2.2.2
mgt.example.com.  4962    IN      A       1.1.1.1
mgt.example.com.  19497   IN      A       3.3.3.3
```

2. Create Windows Firewall rule, setup program or port or etc
3. Set DisplayName to `access:mgt.example.com` and save
4. Download this as zip-archive, unpack
5. Run install.bat
6. Click `Refresh` on Windows Firewall rules, open created rule and verify Remote IP addresses: `fwdns` dynamically set their from DNS every 5 minutes
7. Enjoy!


