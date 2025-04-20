variable "app_name" { type = string }
variable "region"   { type = string }
variable "registry_type" {
  type = string
  default = "DOCKER_HUB"
}
variable "image_repository" { type = string }
variable "image_tag"        { type = string }
variable "domain"           { type = string }
variable "envs"             { type = map(string) default = {} }
