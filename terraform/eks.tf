resource "aws_eks_cluster" "main" {

  name     = "devops-eks"
  role_arn = aws_iam_role.eks_cluster_role.arn
  
  access_config {
  authentication_mode                         = "API_AND_CONFIG_MAP"
  bootstrap_cluster_creator_admin_permissions = true
}

  vpc_config {

    subnet_ids = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id,
      aws_subnet.private_1.id,
      aws_subnet.private_2.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
  
}
resource "aws_eks_node_group" "workers" {

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "worker-nodes"

  node_role_arn = aws_iam_role.eks_node_role.arn

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  scaling_config {

    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  depends_on = [
    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.ecr_read_policy
  ]
}