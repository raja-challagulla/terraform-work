## Terraform code to create a VPC in AWS

provider aws {
    region = "ap-southeast-1"
}

resource "aws_vpc" "myvpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    instance_tenancy = "default"
    
    tags = {
        Name = "Terraform"
        Managed_by = "Terraform"
        Environment = "Test"
            }
}

resource "aws_subnet" "pubsubnet" {
    vpc_id = aws_vpc.myvpc.id
    count = length(data.aws_availability_zones.data_azs.names)
    availability_zone = data.aws_availability_zones.data_azs.names[count.index]
    cidr_block = var.subnets[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "Terraform"
        Managed_by = "Terraform"
        VPC_Name ="Test"
        az = data.aws_availability_zones.data_azs.names[count.index]
    }      
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id

    tags = {
        Name = "IGW for Terraform VPC"
        Managed_by = "Terraform"
    }

}

resource "aws_route_table" "routetable" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "public route table"
        Managed_by = "Terraform"
    }

}

resource "aws_main_route_table_association" "mainroute" {
    vpc_id = aws_vpc.myvpc.id
    route_table_id = aws_route_table.routetable.id
}

output "data_sources" {
    value = data.aws_availability_zones.data_azs

}