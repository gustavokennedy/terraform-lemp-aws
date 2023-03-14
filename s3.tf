terraform {
  required_version = "1.4.0"

  required_providers {

  	aws = {
		source = "hashicorp/aws"
		version = "4.58.0"
		}
	}
}

#provider "aws" {
#	  region = "us-east-1"
#	  profile = "tf01"
#}

resource "aws_s3_bucket" "test-bucket" {
	  bucket = "my-tf-test-bucket-kennedyrenkel"

	tags = {
		Name        = "My bucket"
		Environment = "Dev"
		}
	}
