variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "S3 bucket for Terraform backend"
  type        = string
  default     = "dheeraj-terraform-backend-2025"
}