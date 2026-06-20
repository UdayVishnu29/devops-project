# Elastic IP for NAT Gateway

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

# NAT Gateway in Public Subnet

resource "aws_nat_gateway" "nat" {

  allocation_id = aws_eip.nat_eip.id

  subnet_id = aws_subnet.public_1.id

  tags = {
    Name = "devops-nat-gateway"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}

# Private Route Table

resource "aws_route_table" "private_rt" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

# Associate Private Subnet 1

resource "aws_route_table_association" "private_1" {

  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_rt.id
}

# Associate Private Subnet 2

resource "aws_route_table_association" "private_2" {

  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_rt.id
}
