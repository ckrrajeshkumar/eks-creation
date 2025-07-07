resource "aws_eks_cluster" "babaji-cluster"{
  name = var.clustername
  role_arn = aws_iam_role.babaji-role.arn
  version = "1.33"

  vpc_config {
    subnet_ids = [aws_subnet.babaji-pubsub1.id, aws_subnet.babaji-pubsub2.id]
  }
  depends_on = [
  aws_iam_role.babaji-role
  ]
  tags={
    Name = "clustertype"
    Environment = var.env
  }
}