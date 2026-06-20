output "ecr_url" {
  value = aws_ecr_repository.node_app.repository_url
}
output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "ansible_public_ip" {
  value = aws_instance.ansible.public_ip
}

output "eks_cluster_name" {
  value = aws_eks_cluster.main.name
}