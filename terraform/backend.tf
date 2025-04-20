terraform {
  backend "s3" {
    endpoint                     = "${var.spaces_endpoint}"        # e.g. "nyc3.digitaloceanspaces.com"
    bucket                       = var.spaces_bucket              # "tf-state-bucket"
    key                          = "app/${terraform.workspace}.tfstate"
    region                       = var.spaces_region              # "us-east-1" (arbitrary)
    access_key                   = var.do_access_key              # DO Spaces key
    secret_key                   = var.do_secret_key              # DO Spaces secret
    skip_credentials_validation  = true                           # skip AWS-specific checks
    skip_metadata_api_check      = true                           # skip AWS metadata calls
    skip_requesting_account_id   = true                           # skip AWS STS calls
    acl                          = "private"
  }
}
