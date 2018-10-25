#!/bin/bash

function log {
  TYP=$1 # ER, WR, OK
  MSG=$2
  NOW=$(date +"%m-%d-%Y %T")

  case "$TYP" in
    "IN")
      echo -e "[+] ${IN}${0#\.\/}: [${NOW}] INFO ${MSG}${NC}"
    ;;
    "ER")
      echo -e "[!] ${ER}${0#\.\/}: [${NOW}] ERROR ${MSG}${NC}"
    ;;
    "WR")
      echo -e "[!] ${WR}${0#\.\/}: [${NOW}] WARNING ${MSG}${NC}"
    ;;
    "OK")
      echo -e "[+] ${OK}${0#\.\/}: [${NOW}] SUCCESS ${MSG}${NC}"
    ;;
    "DB")
      echo -e "[?] ${DB}${0#\.\/}: [${NOW}] DEBUG ${MSG}${NC}"
    ;;
    *)
      echo -e "[?] ${DB}${0#\.\/}: [${NOW}] DEBUG Something went wrong when trying to print this error:
           >>> TYP(${TYP}),
           >>> MSG($MSG),
           >>> NOW(${NOW})${NC}"
    ;;
esac
}
