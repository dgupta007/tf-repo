/*terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "<5.16.1"
    }
  }
}*/

provider "aws" {
    region = "ap-south-1"
    profile = "csos3"
}


/* COUNT & COUNT INDEX
#Creating 3 ec2 instances with the names specified in the above list named instance_names

variable "instance_names" {
  default = ["dev","stage","prod"]
}

resource "aws_instance" "new" {
  ami           = "ami-055e031b0f6e2d52e" #Changes according to AWS region
  instance_type = "t2.micro"
  tags = {
    Name = var.instance_names[count.index] #Names instances like dev,stage,prod
  }
  count = 3
}
*/


/* COUNT & COUNT INDEX; CONDITIONAL EXPRESSIONS
#Having the user decide if he wants to create a dev instance or a prod instance
# & the no. of instances to create has been coded as a condition

variable "is_test" {}

resource "aws_instance" "dev" {
  ami           = "ami-055e031b0f6e2d52e" #Changes according to AWS region
  instance_type = "t2.micro"
  count = var.is_test == true ? 3 : 0    #If value of is_test variable is true; count = 3
  tags = {Name="dev-${count.index}"}     #Assign names like dev-0, dev-1 to instances
}

resource "aws_instance" "prod" {
  ami           = "ami-055e031b0f6e2d52e" #Changes according to AWS region
  instance_type = "t2.large"
  count = var.is_test == false ? 3 : 0     #If value of is_test variable is false; count = 3
  tags = {Name="prod-${count.index}"}      #Assign names like prod-0, prod-1 to instances
}
*/


/* LOCAL VALUES
#Use same tags for all resources w/o having to specify tags a no. of times, using locals

variable "is_test" {}

locals {
  common_tags = {
    Owner = "SecOps Team"
    service = "backend"
  }
}

resource "aws_instance" "prod" {
  ami           = "ami-055e031b0f6e2d52e"
  instance_type = "t2.large"
  count = var.is_test == false ? 3 : 0     #If value of is_test variable is false; count = 3
  tags = local.common_tags
}
*/