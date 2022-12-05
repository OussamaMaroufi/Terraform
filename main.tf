provider "aws" {
}

variable "subnet_cidr_block" {
  description = "subnet cidr block"
  default = "10.0.10.0/24"
  type = string
    
}

# reference global env var
#export TF_VAR_<NAME>="value"
variable avail_zone {}

variable "cidr_blocks"{
    description = "cidr blocks for vpc and subnets"
    type = list(object({
        cidr_block = string 
        name = string  #for validation ,restriction
    }))
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
}

variable "environment"{
    description = "deployment environment"
}

resource "aws_vpc" "development-vpc"{
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
        Name: var.cidr_blocks[0].name
        
    } 
}

resource "aws_subnet" "dev-subnet1"{
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name: var.cidr_blocks[1].name
    }
}

# result will be stored in the second arg
data "aws_vpc" "existing_vpc"{
    default = true
}

resource "aws_subnet" "dev-subnet2"{
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.96.0/20"
    availability_zone = "us-east-1a"
    tags = {
        Name: "subnet-2-dev"
    }
} 

# one output value for each attribute even if it is for the same ressource
output "dev-vpc-id" {
  value  = aws_vpc.development-vpc.id

}

output "dev-subnet-id" {
  value  = aws_subnet.dev-subnet1.id

}



