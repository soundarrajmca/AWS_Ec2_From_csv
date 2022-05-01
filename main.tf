

locals {
  ec2_list = csvdecode(file("${path.module}/ec2_list.csv"))
}

resource "aws_instance" "default" {

count = length(local.ec2_list)
  
ami = local.ec2_list[count.index].ami
instance_type = local.ec2_list[count.index].instance_type
host_id = local.ec2_list[count.index].host_id
subnet_id = local.ec2_list[count.index].subnet_id
private_ip = local.ec2_list[count.index].private_ip
vpc_security_group_ids = [
  local.ec2_list[count.index].vpc_security_group_ids
]


#  disable_api_termination = "true"
ebs_optimized = "true"

 root_block_device {
    
    volume_type           = local.ec2_list[count.index].volume_type
    # volume_size           = local.ec2_list[count.index].volume_size
    delete_on_termination = "true"
  }
  
  tags = {
    Name = "${local.ec2_list[count.index].name}"
    Owner = "${local.ec2_list[count.index].owner_name}"
    BU = "${local.ec2_list[count.index].b_unit}"
  }
}



