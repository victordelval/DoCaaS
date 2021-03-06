#!/bin/bash

. ./../demos/loadvariables.sh

aws cloudformation delete-stack --stack-name docaas-dynamos
aws cloudformation wait stack-delete-complete --stack-name docaas-dynamos

sam package --template-file dynamotemplate.yaml --s3-bucket $BUCKET --output-template-file packaged.yaml --region $REGION
sam deploy --template-file packaged.yaml --stack-name docaas-dynamos --capabilities CAPABILITY_NAMED_IAM --region $REGION

rm -f packaged.yaml