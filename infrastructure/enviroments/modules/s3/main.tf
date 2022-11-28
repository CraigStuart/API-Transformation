resource "aws_ecr_repository" "ecr_registry" {
  name                 = "streamlit-fe"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}