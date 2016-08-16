#HelpScout Test Project Documentation

This is the code for the HelpScout Test Project. This code will to deploy a CI/CD pipeline using automation tools. The stack will be composed of : 

- GitHub ==> Version control & Code Repository
- CloudFormation ==> Infrastructure Automation
- CodePipeline ==> Continuous Integration/Deployment
- Jenkins ==> Build & Testing
- Elastic Beanstalk ==> Deployment & Infrastructure Management
- ServerSpec (Ruby)  ==> Infrastructure Testing

##USAGE INSTRUCTIONS

Pre-Requisites
-----------------------
- You must use aws cli to run the command. You should use aws configure to setup your access key and preferred region. 

- The user must have Full access + IAM creation permission since we will create multiple resources in the account

- To run the tests, you need to have ruby installed. Following gems must be installed : serverspec


Instructions
-----------------------

###Stack Creation

Using AWS CLI, in the console input the following command :
**DO NOT FORGET to change the key parameter value to your own KeyPair Name.

  aws cloudformation create-stack --stack-name "MyHSPipelineProjectFinal" --template-url "https://s3-us-west-2.amazonaws.com/altaas/hsproject/hsproject.json"  --parameters ParameterKey=KeyName,ParameterValue="YOUR_OWN_KEY_PAIR_NAME" --capabilities CAPABILITY_IAM

This code will get the CloudFormation template from my repository and will trigger the stack creation.

###Monitor Stack Creation
To monitor the stack creation from the console, input the following command : 

    aws cloudformation describe-stacks --stack-name MyHSPipelineProjectFinal

To monitor the stack with the GUI, use this URL and specify the region you've put previously :

https://console.aws.amazon.com/cloudformation/home?region=YOUR_REGION#/

When the stack creation is complete, you will have 2 outputs URL

- Jenkins Server URL
- Elastic Beanstalk Environment

###Infrastructure Testing
Using your local development environment input

    serverspec-init

Additional Notes
-------------------------
- After the stack creation, there is a delay before the actual script is deployed on the instances. The deployment pipeline will be triggered in the following minutes and will deploy the code, so be patient :). 

- There seems to be some region where the AWS::CodePipeline::CustomAction is not supported. This was the case when I deployed the code to us-west-1 (California) region. 


> Written with [StackEdit](https://stackedit.io/).