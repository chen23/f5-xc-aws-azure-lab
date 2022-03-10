include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../azure-workload","../azure-site"]
}

dependency "workloads" {
  config_path = "../azure-workload"
}

inputs = {
    workload_ip   = dependency.workloads.outputs.workload_private_ip
}

