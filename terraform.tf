terraform {
 backend "s3" {
  bucket = "alhaffar-public-bucket"
  key = "terraform.tfstate"
  region = "us-east-2"
  }

}
