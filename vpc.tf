resource "aws_vpc" "cluster_vpc" {
  cidr_block = "10.0.0.0/16" # replace with your desired CIDR block
  tags = {
    Name = "eks-cluster-vpc"
  }
}

resource "aws_internet_gateway" "cluster_igw" {
  vpc_id = aws_vpc.cluster_vpc.id
  tags = {
    Name = "eks-cluster-igw"
  }
}

resource "aws_route_table" "cluster_rt" {
  vpc_id = aws_vpc.cluster_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cluster_igw.id
  }
  tags = {
    Name = "eks-cluster-rt"
  }
}

resource "aws_route_table_association" "cluster_rta" {
  subnet_id = aws_subnet.cluster_subnet.id
  route_table_id = aws_route_table.cluster_rt.id
}

resource "aws_subnet" "cluster_subnet" {
  vpc_id = aws_vpc.cluster_vpc.id
  cidr_block = "10.0.1.0/24" # replace with your desired CIDR block
  tags = {
    Name = "eks-cluster-subnet"
  }
}
