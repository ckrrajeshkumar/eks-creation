resource "aws_vpc" "babaji-vpc"{
  cidr_block = var.vpccidr
  tags={
    Name = var.vpcname
  }
}
resource "aws_subnet" "babaji-pubsub1"{
  vpc_id = aws_vpc.babaji-vpc.id
  cidr_block = var.pubsub1
  availability_zone = var.pubsubaz1
  map_public_ip_on_launch = true
  tags={
    Name = var.pubsubname1
  }
}
resource "aws_subnet" "babaji-pubsub2"{
  vpc_id = aws_vpc.babaji-vpc.id
  cidr_block = var.pubsub2
  availability_zone = var.pubsubaz2
  map_public_ip_on_launch = true
  tags={
    Name = var.pubsubname2
  }
}
resource "aws_internet_gateway" "babaji-igw"{
  vpc_id = aws_vpc.babaji-vpc.id
  tags={
    Name = var.igwname
  }
}
resource "aws_route_table" "babaji-rt"{
  vpc_id = aws_vpc.babaji-vpc.id
  route{
    cidr_block = var.igwcidr
    gateway_id = aws_internet_gateway.babaji-igw.id
  }
}
resource "aws_route_table_association" "babaji-pubrta1"{
  subnet_id = aws_subnet.babaji-pubsub1.id
  route_table_id = aws_route_table.babaji-rt.id
}
resource "aws_route_table_association" "babaji-pubrta2"{
  subnet_id = aws_subnet.babaji-pubsub2.id
  route_table_id = aws_route_table.babaji-rt.id
}