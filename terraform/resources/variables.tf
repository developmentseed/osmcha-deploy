variable "environment" {
    description = "The environment to deploy to"
    default = "production"
}

variable "region" {
    description = "The region to deploy to"
    default = "us-east-1"
}

variable "database_password" {
    description = "The password for the database"
    sensitive = true
}


locals {
    stack_id = "osmcha"
    prefix = "${local.stack_id}-${var.environment}"
    cluster_name = "${local.prefix}-cluster"

    tags = {
        Project = "osmcha"
    }
}