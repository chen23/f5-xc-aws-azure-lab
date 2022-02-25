# F5 Distributed Cloud AWS/Azure Lab

## Overview
Lab environment for AWS/Azure Multi-Cloud Networking.

## Getting Started
This uses terraform and [terragrunt](TERRAGRUNT.md) to deploy resources.

## Installation
[Install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli). For greater flexibility in managing the version of Terraform you're using, you may consider using [tfenv](https://github.com/tfutils/tfenv)

## Usage
To deploy the AWS site start in the "base-aws-network" directory.  Run "terraform init".  Configure the necessary variables.  Run "terraform apply".

After you deploy the base networking you can deploy the "tgw-site" directory.  Note that you must run the "base-aws-network" terraform first.  Run "terraform init" and "terraform apply".

## Development
Outline any requirements to setup a development environment if someone would like to contribute.  You may also link to another file for this information. 

## Support
For support, please open a GitHub issue.  Note, the code in this repository is community supported and is not supported by F5 Networks.  For a complete list of supported projects please reference [SUPPORT.md](SUPPORT.md).

## Community Code of Conduct
Please refer to the [F5 DevCentral Community Code of Conduct](code_of_conduct.md).


## License
[Apache License 2.0](LICENSE)

## Copyright
Copyright 2014-2022 F5 Networks Inc.


### F5 Networks Contributor License Agreement

Before you start contributing to any project sponsored by F5 Networks, Inc. (F5) on GitHub, you will need to sign a Contributor License Agreement (CLA).

If you are signing as an individual, we recommend that you talk to your employer (if applicable) before signing the CLA since some employment agreements may have restrictions on your contributions to other projects.
Otherwise by submitting a CLA you represent that you are legally entitled to grant the licenses recited therein.

If your employer has rights to intellectual property that you create, such as your contributions, you represent that you have received permission to make contributions on behalf of that employer, that your employer has waived such rights for your contributions, or that your employer has executed a separate CLA with F5.

If you are signing on behalf of a company, you represent that you are legally entitled to grant the license recited therein.
You represent further that each employee of the entity that submits contributions is authorized to submit such contributions on behalf of the entity pursuant to the CLA.