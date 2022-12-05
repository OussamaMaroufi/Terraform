subnet_cidr_block = "10.0.40.0/24"
vpc_cidr_block = "10.0.0.0/16"
environment = "development"
# cidr_blocks = ["10.0.0.0/16","10.0.40.0/24"]

# we can also have a type of object in vars
cidr_blocks = [
            {cidr_block = "10.0.0.0/16", name = "dev-vpc"},
            {cidr_block = "10.0.40.0/24" , name = "dev-subnet"}
            ]
