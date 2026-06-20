resource "aws_ecr_repository" "node_app" {
  name = "fake-ecommerce-api"

  image_scanning_configuration {
    scan_on_push = true
  }
}