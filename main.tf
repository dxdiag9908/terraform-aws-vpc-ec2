# Define the provider
provider "aws" {
  region = "eu-north-1" # You can choose your preferred region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create a Subnet
resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Create an EC2 instance
resource "aws_instance" "my_instance" {
  ami           = "ami-008f8b1de678e93a6" # Update with your region's latest Amazon Linux AMI
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.main_subnet.id
  key_name      = "my-key-pair"  # Make sure you have an EC2 key pair set up

  tags = {
    Name = "MyEC2Instance"
  }
}

