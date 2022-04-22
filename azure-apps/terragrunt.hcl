include "root" {
  path = find_in_parent_folders()
}

terraform {

    before_hook "pre-check" {
        commands = ["apply","plan"]
        execute  = ["./pre-check.sh"]
    }

}

dependencies {
  paths = ["../azure-workload","../azure-site"]
}

dependency "workloads" {
  config_path = "../azure-workload"
  mock_outputs = {
    workload_private_ip = "1.1.1.1"
  }
}

inputs = {
    workload_ip   = dependency.workloads.outputs.workload_private_ip
}

