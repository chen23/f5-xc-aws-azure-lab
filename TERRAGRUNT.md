## Install Terraform
[Install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli). Or, for greater flexibility in managing the version of Terraform you're using, you may consider using [tfenv](https://github.com/tfutils/tfenv)

## Install Terragrunt
The [documentation](https://terragrunt.gruntwork.io/docs/getting-started/install/) is the best place to start.

## Edit the root terragrunt.hcl
- copy terragrunt.hcl.example to terragrunt.hcl
- move terragrunt.hcl up one directory to get it out of the source control path (```mv terragrunt.hcl ../```)
- edit the terragrunt.hcl file you just moved as follows

adjust the value in the *env_vars* and *input* stanzas as appropriate
```hcl
terraform {
    extra_arguments "volterra" {
        commands = ["apply","plan","destroy"]
        arguments = []
        env_vars = {
            VES_P12_PASSWORD  = "secret"
            VOLT_API_URL      = "https://tenant.console.ves.volterra.io/api"
            VOLT_API_TIMEOUT  = "60s"
            VOLT_API_P12_FILE = "/path/to/my.p12"
            VOLTERRA_TOKEN    = "API Token"
        }
    }

}

inputs = {
    projectPrefix          = "menger"
    namespace              = "m-menger"
    trusted_ip             = "192.0.10.1/32"
    volterraTenant         = "tenant"
    volterraCloudCredAWS   = "pre-existing-aws-credential"
    volterraCloudCredAzure = "pre-existing-azure-credential"
    # although these are configurable variables, they are currently
    # hardcoded in places, so it is only recommended to us us-east-1 and us-west-2
    awsRegion              = "us-east-1"
    awsRegion2             = "us-west-2"
    azureRegion            = "westus2"
    # this AWS key name must exist in both regions that you want to test
    ssh_key                = "ec2-key-name"
}
```
you should be able to leave the ```terragrunt.hcl``` files in the subdirectories as-is.

## Run Terragrunt
Review the dependencies interpreted by Terragrunt
```shell
terragrunt graph-dependencies
```

## Run Terragrunt for a single AWS Site

### base-aws-network

To start you will want to build the base-aws-network.
This directory will build out supporting resources by using terraform directly against the AWS APIs.

```
$ cd base-aws-network
$ terragrunt init
$ terragrunt plan
$ terragrunt apply
```

This will create 3 AWS VPCs:
- Service VPC (will host XC Mesh nodes)
- Spoke VPC (will host EC2 jumphost/workload)
- Spoke VPC #2 (will host EC2 jumhost/workload)

The VPCs will be created with an "external" Route Table
that will be configured to use an Internet Gateway and attached to 3 "external" subnets that are in 3 different AZs.

Once this completes you can proceed to deploying your first XC AWS TGW Site

### tgw-site

Ensure that you have download an API certificate and generated an API token from your Distributed Cloud tenant.  You should have previously configured it in 
your top-level `terragrunt.hcl` file.

You will also need to ensure that you have created a "Cloud Credential" for AWS (AcceessKey/AccessSecret) in your tenant and that the name matches the name that is configured in your `terragrunt.hcl` file.

This directory will communicate only with the Distributed Cloud API using the Distributed Cloud terraform provider.  

The Distributed Cloud platform will make use of 

From the top-level directory.

```
$ cd tgw-site
$ terragrunt init
$ terragrunt plan
$ terragrunt apply
```

This should deploy a single AWS TGW Site.  This will consist of the following resources.

- 3 XC Mesh nodes deployed in the Services VPC
- 1 AWS Transit Gateway
- 2 AWS TGW VPC Attachments to each Spoke VPC (previously created in `base-aws-network`)

Note that it may take ~10 minutes for this terragrunt apply to complete.

After it completes you can proceed to deploying workload resources into 
the Spoke VPCs.

### tgw-workload

This directory will make use of the terraform AWS provider to create additional example EC2 resources.  Similar to before you will run several `terragrunt` commands, but note that you will not be able to run `apply` until AFTER your XC TGW Site has gone into an "ONLINE" state (~10 minutes after your `apply` from the `tgw-site` directory completes).

From the top-level directory
```
$ cd tgw-workload
$ terragrunt init
$ terragrunt apply
```
Once this completes you will have the following additional resources.

- 1 jumphost in each spoke VPC attached to a public subnet (2 total)
- 1 workload in each spoke VPC attached to a private subnet (2 total)

Note that in the previous `tgw-site` step the default route table for each Spoke VPC was modified by the Distributed Cloud process.  It created a route for 0.0.0.0/0 that sends all traffic via a VPC TGW attachment to the 3 XC Mesh nodes that are in the Services VPC.

The 3 XC Mesh nodes in the Services VPC are attached to the AWS TGW via
an AWS TGW VPN attachment.

Once the jumphost resources are online you should be able to SSH to them using the ssh key that you have configured in your AWS account.  To access the workload resource you will need to setup SSH forwarding to allow you to pivot from the jumphost to the workload VM.  i.e. if the output is.

```
AWS_INSTANCE = "192.0.2.10"
AWS_INSTANCE2 = "192.02.20"
workload_ip = "10.0.2.9"
workload_ip2 = "10.0.50.218"
```

You can setup `ssh-agent` to add your private key.  Then login to the jumphost.

```
ssh -A ubuntu@192.0.2.10
```

Once on the 192.0.2.10 host you can then pivot to the workload VM.

```
ssh 10.0.2.9
```

From each workload instance you should be able to access the other workload.  An example from the first workload VM.

```
ubuntu@ip-10-0-2-9:~$ ping -c 3 10.0.50.218
PING 10.0.50.218 (10.0.50.218) 56(84) bytes of data.
64 bytes from 10.0.50.218: icmp_seq=1 ttl=60 time=4.15 ms
64 bytes from 10.0.50.218: icmp_seq=2 ttl=60 time=4.06 ms
64 bytes from 10.0.50.218: icmp_seq=3 ttl=60 time=3.96 ms

--- 10.0.50.218 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 3.967/4.062/4.154/0.106 ms
ubuntu@ip-10-0-2-9:~$ curl 10.0.50.218:8080/txt
....
      Server IP: 10.0.50.218
    Server Port: 8080

      Client IP: 10.0.2.9
    Client Port: 57346

Client Protocol: HTTP
 Request Method: GET
    Request URI: /txt

    host_header: 10.0.50.218
     user-agent: curl/7.58.0
```     

####
## Run Everything (Optional)

The following will build the entire environment and assumes you have credentials in all clouds.  This is left for reference, but it is recommended that you using the steps above to do the deployment by individual directories.

Currently the repo has mainly been tested with AWS only and the Azure site may not be fully 
functional yet

Build all of the resources
```shell
terragrunt run-all apply
```

Review the proposed order of execution and enter **y** if it looks apprpriate 
```shell
INFO[0000] The stack at /home/mjmenger/f5-xc-aws-azure-lab will be processed in the following order for command apply:
Group 1
- Module /home/mjmenger/f5-xc-aws-azure-lab/base-aws-network
- Module /home/mjmenger/f5-xc-aws-azure-lab/base-azure-network

Group 2
- Module /home/mjmenger/f5-xc-aws-azure-lab/azure-site
- Module /home/mjmenger/f5-xc-aws-azure-lab/tgw-site

Group 3
- Module /home/mjmenger/f5-xc-aws-azure-lab/tgw-workload
 
Are you sure you want to run 'terragrunt apply' in each folder of the stack described above? (y/n) 
```

If you want to execute the ```terragrunt apply``` commands discretely, you can cd into each of the subdirectories and enter ```terragrunt apply```.




## Clean Up?
you should be able to clean up the cloud resources with ```terragrunt run-all destroy```. You can also cd into each directory discretely and run ```terragrunt destroy```. Because of the dependency management performed by terragrunt, you won't be able to run ```terraform destroy```, except for those directories without dependencies like **base-aws-network** and **base-azure-network**.


If you've deleted everything with terragrunt or terraform and you want to save disk space on terraform providers and modules, you can try the following. YOU MAY LOSE STUFF THAT'S PRECIOUS TO YOU. IF YOU'RE NOT CERTAIN THEN DON'T DO THIS.
```shell
# remove the providers and modules you've downloaded
find . -type d -name ".terraform" -exec rm -rf "{}" \;
# remove the configuration lock file unless you don't want to 
find . -type f -name ".terraform.lock.hcl" -delete
# remove the state file because there's nothing to track the state of ... you hope
find . -type f -name "terraform.tfstate*" -delete
```