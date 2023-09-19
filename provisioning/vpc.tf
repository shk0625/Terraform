resource "aws_vpc" "testVPC" {
    cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "testVpc"
  }
}

resource "aws_subnet" "test_public_subnet" {
    vpc_id = aws_vpc.testVPC.id
    cidr_block = "10.0.1.0/24"

    tags = {
      Name = "Public-subnet-2a"
    }
  
}

resource "aws_subnet" "test-private-subnet" {
    vpc_id = aws_vpc.testVPC.id
    cidr_block = "10.0.10.0/24"

    tags = {
      Name ="private-subnet-2a"
    }
  
}

resource "aws_internet_gateway" "test-igw" {
    
  
}