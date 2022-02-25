## install Terragrunt
The [documentation](https://terragrunt.gruntwork.io/docs/getting-started/install/) is the best place to start.

## setup environment variables
```bash
export VOLT_API_P12_FILE=/path/to/my.p12
export VES_P12_PASSWORD='secretp12pass'
export VOLT_API_TIMEOUT='60s'
export VOLT_API_URL=https://tenant.console.ves.volterra.io/api
```

## edit the root terragrunt.hcl
adjust the value in the *input* stanza as appropriate
```hcl
terraform {


}

inputs = {
    projectPrefix          = "menger"
    namespace              = "m-menger"
    trusted_ip             = "192.0.1.0/32"
    volterraTenant         = "f5-sa"
    volterraCloudCredAWS   = "m-menger-aws-cred"
    volterraCloudCredAzure = "m-menger-azure-cred"
    awsRegion              = "us-east-1"
    ssh_key                = "my-ec2-key-name"
}
```
you should be able to leave the ```terragrunt.hcl``` files in the subdirectories as-is.

## run terragrunt

```shell
terragrunt run-all apply
```

Review the proposed order of execution and enter *y* if it looks apprpriate 
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
If you've deleted everything with terragrunt or terraform and you want to save disk space on terraform providers and modules, you can try the following. YOU MAY LOSE STUFF THAT'S PRECIOUS TO YOU. IF YOU'RE NOT CERTAIN THEN DON'T DO THIS.
```shell
# remove the providers and modules you've downloaded
find . -type d -name ".terraform" -exec rm -rf "{}" \;
# remove the configuration lock file unless you don't want to 
find . -type f -name ".terraform.lock.hcl" -delete
# remove the state file because there's nothing to track the state of ... you hope
find . -type f -name "terraform.tfstate*" -delete
```