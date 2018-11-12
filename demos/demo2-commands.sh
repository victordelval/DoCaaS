





aws cognito-identity list-identity-pools --max-results 50








cd ../lambdas
./deploy-demo2-SAM.sh






aws iam create-policy --policy-name DoCaaSDynamoPolicyForAuthenticated --policy-document file://cognito-auth-policy1.json
aws iam create-policy --policy-name DoCaaSDefaultPolicyForAuthenticated --policy-document file://cognito-auth-policy2.json







./cognitosetup.sh







rsync -ax --exclude 'node_modules' ../front-end/customer1 ../







aws cloudformation describe-stacks --stack-name docaas --query "Stacks[0].Outputs" 






cd ../docaas-app
npm install
npm run-script build
aws s3 sync build/ s3://docaas --acl public-read-write #use your bucket instead of docaas
