output "instance_role_arn" {
  description = "Role ARN assigned to the Postfix instance."
  value       = module.instance-profile.instance_role_arn
}
