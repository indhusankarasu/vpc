resource "aws_vpc" "testvpc" {
  cidr_block = var.test_vpc
  tags = {
    Name="test_vpc"
  }
}
resource "aws_subnet" "testsub01" {
  vpc_id = aws_vpc.testvpc.id
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
  cidr_block = var.testsub01
  tags = {
    Name = "testsub01"
  }
}
resource "aws_subnet" "testsub02" {
  vpc_id = aws_vpc.testvpc.id
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true
  cidr_block = var.testsub02
  tags = {
    Name = "testsub02"
  }
}
resource "aws_internet_gateway" "testigw" {
  vpc_id = aws_vpc.testvpc.id
  tags = {
    Name = "testigw"
  }
}
resource "aws_route_table" "test_rt" {
  vpc_id         = aws_vpc.testvpc.id
  tags = {
    Name="test_rt"
  }
  route {
    cidr_block = var.test_rt
    gateway_id = aws_internet_gateway.testigw.id
  }
}
resource "aws_route_table_association" "test_rtassociation" {
  route_table_id = aws_route_table.test_rt.id
  subnet_id = aws_subnet.testsub01.id
}
resource "aws_route_table_association" "test_rtassoc2" {
  route_table_id = aws_route_table.test_rt.id
  subnet_id = aws_subnet.testsub02.id
}