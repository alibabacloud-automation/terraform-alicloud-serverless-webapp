data "archive_file" "zip" {
  type        = var.archive_file_type
  source_file = var.fc_file_name
  output_path = var.archive_file_output_path
}