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


Instructions
-----------------------

###Stack Creation

Using AWS CLI, in the console input the following command :

####Parameters

-  **Key Name**  :  Your own key pair that is installed in your region
- **MyOAuthToken**  : GitHub Token provided by email. This can't be pushed in github

------------

    aws cloudformation create-stack --stack-name "MyHSPipelineProjectFinal" --template-url "https://s3-us-west-2.amazonaws.com/altaas/hsproject/hsproject.json"  --parameters ParameterKey=KeyName,ParameterValue="YOUR_OWN_KEY_PAIR_NAME" ParameterKey=MyOAuthToken,ParameterValue="PROVIDED_TOKEN" --capabilities CAPABILITY_IAM

--------

This code will get the CloudFormation template from my repository and will trigger the stack creation.

**Note : This task was mainly tested in us-east-1 and us-west-2.

###Monitor Stack Creation
To monitor the stack creation from the console, input the following command : 

    aws cloudformation describe-stacks --stack-name MyHSPipelineProjectFinal

To monitor the stack with the GUI, use this URL and specify the region you've put previously :

https://console.aws.amazon.com/cloudformation/home?region=YOUR_REGION#/

When the stack creation is complete, you will have 2 outputs URL

- Jenkins Server URL
- Elastic Beanstalk Environment

###Infrastructure Testing
Test were only implemented on the Jenkins Server since this was the instance with the most logical configuration. Test result can be found directly on the instance in the following path :

    /opt/serverspec/reports/.html
    /opt/serverspec/reports/.json

The HTML file will be a colored with filtering options.

![Jenkins Instance Test Sample](https://s3-us-west-2.amazonaws.com/altaas/hsproject/JenkinsTestingResults.PNG)

Additional Notes
-------------------------
- After the stack creation, there is a delay before the actual script is deployed on the instances. The deployment pipeline will be triggered in the following minutes and will deploy the code, so be patient :). Once the full pipeline is executed, the title will turn red and the the subtext will be removed.
![enter image description here](https://s3-us-west-2.amazonaws.com/altaas/hsproject/ImageExecution.png)


- There seems to be some region where the AWS::CodePipeline::CustomAction is not supported. This was the case when I deployed the code to us-west-1 (California) region. 


> Written with [StackEdit](https://stackedit.io/).
