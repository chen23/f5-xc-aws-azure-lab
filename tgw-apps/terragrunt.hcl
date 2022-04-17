include "root" {
  path = find_in_parent_folders()
}



dependencies {
  paths = ["../tgw-site","../tgw-workload"]
}

dependency "workloads" {
  config_path = "../tgw-workload"
  mock_outputs = {
    workload_ip = ""
    workload_ip2 = ""
  }
}

inputs = {
    workload_ip = dependency.workloads.outputs.workload_ip
    workload_ip2 = dependency.workloads.outputs.workload_ip2    
}
