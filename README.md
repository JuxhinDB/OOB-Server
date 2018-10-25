# Out-of-Band DNS Bind Server

A simple Bind9 server that acts as an open DNS resolver. 

**Note**—for this to work without specifying nameservers 
(i.e. `dig A +short foo.bar @ns1.foo.bar`), you would need your domain provider
to have the domain point to your custom domain for example:

- ns1.foo.bar => `127.127.127.127`
- ns2.foo.bar => `127.127.127.127`

## Usage

```
Usage: setup DOMAIN_NAME
       setup gbejna.bid
       setup -h
       setup --help

Options:
  -h, --help        Print this help message
```

You can then monitor your Bind9 traffic like so:

```
foo@vm13407021391238:~$ sudo tail -f /var/log/named/named.log
25-Oct-2018 13:22:18.015 queries: info: client @0x7f25082bef80 255.255.255.255.16360047 (gbejna.bid): query: gbejna.bid IN A -E(0) (127.127.127.127)
25-Oct-2018 13:22:20.352 queries: info: client @0x7f25082bef80 255.255.255.255.88#61503 (gbejna.bid): query: gbejna.bid IN A -E(0) (127.127.127.127)
25-Oct-2018 13:22:20.654 queries: info: client @0x7f25082bef80 255.255.255.255.60#18303 (gbejna.bid): query: gbejna.bid IN A -E(0) (127.127.127.127)
25-Oct-2018 13:22:20.903 queries: info: client @0x7f25082bef80 255.255.255.255.60#36200 (gbejna.bid): query: gbejna.bid IN A -E(0) (127.127.127.127)
25-Oct-2018 13:22:21.371 queries: info: client @0x7f25082bef80 255.255.255.255.60#18303 (gbejna.bid): query: gbejna.bid IN A -E(0) (127.127.127.127)
25-Oct-2018 13:22:21.617 queries: info: client @0x7f25082bef80 255.255.255.255.60#60065 (gbejna.bid): query: gbejna.bid IN A -E(0) (127.127.127.127)
25-Oct-2018 13:22:22.080 queries: info: client @0x7f25082bef80 255.255.255.255.60#51886 (gbejna.bid): query: gbejna.bid IN A -E(0) (127.127.127.127)
25-Oct-2018 13:22:22.335 queries: info: client @0x7f25082bef80 255.255.255.255.60#51410 (gbejna.bid): query: gbejna.bid IN A -E(0) (127.127.127.127)
25-Oct-2018 13:22:22.778 queries: info: client @0x7f25082bef80 255.255.255.255.60#61740 (gbejna.bid): query: gbejna.bid IN A -E(0) (127.127.127.127)
25-Oct-2018 13:22:23.030 queries: info: client @0x7f25082bef80 255.255.255.255.60#20153 (gbejna.bid): query: gbejna.bid IN A -E(0) (127.127.127.127)
```

## Why

This is very useful when wanting to test for some very hairy vulnerabilities
such as XXE, SSRF and so on. You can inject payloads with random IDs and 
subdomains like `8273781123-xxe.foo.bar` and `grep` for it in your logs to
see if the payload ever executed.

This is also nice to do with Bind9 because:

- It's super fast, can handle being an open DNS resolver
- DNS outbound traffic is _rarely_ filtered, even if HTTP is