# output "cf_id" {
#   value       = module.cdn.cf_id
#   description = "ID of AWS CloudFront distribution"
# }

# output "cf_arn" {
#   value       = module.cdn.cf_arn
#   description = "ARN of AWS CloudFront distribution"
# }

# output "cf_status" {
#   value       = module.cdn.cf_status
#   description = "Current status of the distribution"
# }

# output "cf_domain_name" {
#   value       = module.cdn.cf_domain_name
#   description = "Domain name corresponding to the distribution"
# }
output "s3_bucket" {
  value       = aws_s3_bucket.b.bucket_domain_name 
  description = "Name of S3 bucket"
}
