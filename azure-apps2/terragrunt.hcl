include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../azure-workload2","../azure-site2"]
}

dependency "workloads" {
  config_path = "../azure-workload2"
  mock_outputs = {
    workload_private_ip = ""
  }
}

inputs = {
    workload_ip   = dependency.workloads.outputs.workload_private_ip
}

