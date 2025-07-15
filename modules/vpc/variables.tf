variable "name" {}
variable "vpc_cidr" {}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_app_subnet_cidrs" {
  type = list(string)
}
variable "private_db_subnet_cidrs" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}
