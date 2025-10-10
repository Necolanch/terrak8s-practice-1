variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "East US"
}

variable "terrak8s-prefix" {
  type    = string
  default = "terrak8s-practice-1"
}