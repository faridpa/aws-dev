# Development(dev) environment in AWS

![image](https://user-images.githubusercontent.com/78159783/163809181-e88914a3-3182-4bfd-b9c7-9c08c2e96340.png)

# Getting started

## How to use this repo:

### Clone the repository 

Initialize your directory: ```terraform init```

Review your infrastructure: ```terraform plan```

If you don't get any errors then do ```terraform apply```

After creating the resources, you will get an output of the instance's public IP

SSH into your instance using ```ssh -i ~/.ssh/mtckey ubuntu@INSTANCE_IP```