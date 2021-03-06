#!/bin/bash

. ./loadvariables.sh

cd ../monoliths/customer2
eb init --platform node.js --region us-west-2

CERTARN='no value'
CERTARN=`aws acm list-certificates | jq --arg DOMAIN "$DOMAIN" '.CertificateSummaryList [] | select(.DomainName==$DOMAIN) .CertificateArn'`
echo $CERTARN

cd .ebextensions/
find alb-secure-listener.config -type f -exec sed -i -e "s,CERTARNGOESHERE,$CERTARN,g" {} \;
rm -f alb-secure-listener.config-e

cd ..
eb create docaas-customer2-eb-env --elb-type application
cd ../../demos
