data "archive_file" "zip" {
  type        = "zip"
  source_file = var.fc_file_name
  output_path = "index.zip"
}
