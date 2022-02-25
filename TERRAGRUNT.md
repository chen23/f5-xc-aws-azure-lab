## Install Terraform
[Install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli). Or, for greater flexibility in managing the version of Terraform you're using, you may consider using [tfenv](https://github.com/tfutils/tfenv)

## install Terragrunt
The [documentation](https://terragrunt.gruntwork.io/docs/getting-started/install/) is the best place to start.

## edit the root terragrunt.hcl
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
        }
    }

    after_hook "experiment" {
        commands = ["apply","plan","destroy"]
        execute  = ["echo","-----------------!!!!!!!!!!!!!!!!! SUPER DONE !!!!!!!!!!!!!!!!!-----------------"]
    }

}

inputs = {
    projectPrefix          = "menger"
    namespace              = "m-menger"
    trusted_ip             = "192.0.10.1/32"
    volterraTenant         = "tenant"
    volterraCloudCredAWS   = "pre-existing-aws-credential"
    volterraCloudCredAzure = "pre-existing-azure-credential"
    awsRegion              = "us-east-1"
    azureRegion            = "westus2"
    ssh_key                = "ec2-key-name"
}
```
you should be able to leave the ```terragrunt.hcl``` files in the subdirectories as-is.

## run terragrunt
Review the dependencies interpreted by Terragrunt
```shell
terragrunt graph-dependencies
```
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




## clean up?
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