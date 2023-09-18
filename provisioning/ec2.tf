resource "aws_instance" "Test1ec2" {
    ami = "ami-0454bb2fefc7de534"
    instance_type = "t2.micro"

    tags = {
        "Name" = "Created By Terraform"
    }
  
}