resource "aws_efs_file_system" "fs" {
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = true
}
