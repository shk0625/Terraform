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
    vpc_id = aws_vpc.seolhee-vpc.id
    tags = {
        Name = "seolhee-igw"
    }
  
}

# create EIP for nat

resource "aws_eip" "seolhee-aws_eip" {
    vpc = true
}

#create nat
resource "aws_nat_gateway" "seolhee-nat" {
    allocation_id = aws_eip.seolhee-aws_eip.id
    subnet_id = aws_subnet.seolhee-public-subnet-2a.id
  tags = {
    Name = "seolhee-nat"
  }
}

# create public rtb

resource "aws_route_table" "seolhee-public-rtb" {
  vpc_id = aws_vpc.seolhee-vpc.id

  tags = {
    Name ="seolhee-public-rtb"
  }
}

# create private rtb
resource "aws_route_table" "seolhee-private-rtb" {
  vpc_id = aws_vpc.seolhee-vpc.id

  tags = {
    Name ="seolhee-private-rtb"
  }
}

#rtb에 igw/nat 할당
resource "aws_route" "seolhee-nat-as" {
  route_table_id = aws_route_table.seolhee-private-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.seolhee-nat.id
}

resource "aws_route" "seolhee-igw-as" {
  route_table_id = aws_route_table.seolhee-public-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.seolhee-igw.id
}

#rtb에 각각 subnet 할당
resource "aws_route_table_association" "seolhee-public-rtb-as-1" {
  subnet_id = aws_subnet.seolhee-public-subnet-2a.id
  route_table_id = aws_route_table.seolhee-public-rtb.id
}

resource "aws_route_table_association" "seolhee-private-rtb-as-1" {
  subnet_id = aws_subnet.seolhee-private-subnet-2a.id
  route_table_id = aws_route_table.seolhee-private-rtb.id
}