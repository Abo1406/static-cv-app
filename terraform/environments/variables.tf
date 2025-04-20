variable "spaces_endpoint" { type = string }
variable "spaces_bucket"   { type = string }
variable "spaces_region"   { type = string }
variable "do_access_key"   { type = string, sensitive = true }
variable "do_secret_key"   { type = string, sensitive = true }
