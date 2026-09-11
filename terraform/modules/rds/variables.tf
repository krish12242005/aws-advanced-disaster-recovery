variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "database_sg_id" {
  type = string
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "database_username" {
  type    = string
  default = "dradmin"
}

variable "database_password" {
  type      = string
  default   = "ChangeMe123!"
  sensitive = true
}
