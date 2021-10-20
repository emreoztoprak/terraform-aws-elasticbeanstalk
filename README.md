# Elastic Beanstalk WebServer Environment with Terraform

 ![Elastic Beanstalk Deployment with Terraform](src/eb-tf.png)

This terraform configuration will create Elastic Beanstalk WebServer Environment Amazon Linux 2 and PHP 8.0, ACM certificate and DNS validation for your domain, Cloudwatch alarms for Elastic Beanstalk Environment and finally it will create A record for your domain and point to Elastic Beanstalk Environment. I also redirected all HTTP traffic to HTTPS in this configuration. I set up dynamically the solution stack so you don't have to worry if a new platform version of PHP 8.0 is released.

<br/>

<br/>

Before deployment create **key pair** and use name of that key pair in variables file. Also you have to existing **SNS Topic** for your alarm notification and **Route53 Public Hosted Zone** for your domain.


<br/>

Change these variables in the terraform.tfvars file with your own before the deployment.

<br/>

```
region = "us-east-1"

domain_name = "example.com"

app_tags = "Example"

application_name = "Example-App"

vpc_id = "vpc-ee2325320"

ec2_subnets = "subnet-d1c325ab"

elb_subnets = ["subnet-d1c325ab","subnet-d1c565ab"]

instance_type = "t3.micro"

disk_size = "20"

keypair = "example"

sshrestrict="12.34.56.78/32"

alarm_sns_topic = "arn:aws:sns:us-east-1:123456788900:TOPIC"

```

<br/>

When everything is ready you can deploy with these 4 commands.

### Deployment

```
terraform init
terraform validate
terraform plan
terraform apply

```
