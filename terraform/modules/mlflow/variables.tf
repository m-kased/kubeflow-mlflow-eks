variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "postgres_port" {
  type        = number
  description = "PostgreSQL port"
  default     = 5432
}

variable "postgres_database" {
  type        = string
  description = "PostgreSQL database name"
  default     = "mlflow"
}

variable "postgres_user" {
  type        = string
  description = "PostgreSQL username"
  default     = "mlflowuser"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name for MLflow artifacts"
  default     = "mlflow-artifacts"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where resources will be created"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the RDS instance"
}

variable "eks_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks of the EKS cluster subnets"
  default     = ["10.0.0.0/16"]
}

variable "terraform_tags" {
  type        = map(string)
}
