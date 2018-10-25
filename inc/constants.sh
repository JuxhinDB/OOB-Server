#!/bin/bash

# Config for /etc/bind/named.conf.log
readonly BIND_NAMED_CONF_LOG="
logging {
  channel bind_log {
    file \"/var/log/named/named.log\" versions 3 size 5m;
    severity info;
    print-category yes;
    print-severity yes;
    print-time yes;
  };
  category default { bind_log; };
  category update { bind_log; };
  category update-security { bind_log; };
  category security { bind_log; };
  category queries { bind_log; };
  category lame-servers { null; };
};"

# Config for logrotate.d/bind to avoid logs getting too big
readonly LOGROTATE_BIND="
/var/log/named/named.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    notifempty
    create 644 bind bind
    postrotate
      /usr/sbin/invoke-rc.d bind9 reload > /dev/null
    endscript
}"

# Config for /etc/bind/db.local used as the DNS response
readonly BIND_DB_LOCAL="
\$TTL    120
@       IN      SOA     ${DOMAIN_NAME}. root.${DOMAIN_NAME}. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@                IN      A       91.239.26.239
*                IN      CNAME   ${DOMAIN_NAME}
@                IN      NS      ns1.${DOMAIN_NAME}.
@                IN      NS      ns2.${DOMAIN_NAME}.
"

# Config to setup Bind9 as a DNS forwarded if the packet is not for us
readonly BIND_NAMED_CONF_OPTIONS="
options {
        directory \"/var/cache/bind\";

        forwarders {
            8.8.8.8;
            8.8.4.4;
        };

        allow-query { any; };

        dnssec-validation auto;

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
"