resource "aws_security_group" "postgres_sg" {
  name        = "mlflow-postgres-sg"
  description = "Security group for MLflow PostgreSQL database"
  vpc_id      = var.vpc_id

  # Allow PostgreSQL traffic from EKS cluster
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    description = "PostgreSQL access from EKS"
    cidr_blocks = var.eks_subnet_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.terraform_tags
}

resource "aws_db_subnet_group" "mlflow_postgres" {
  name       = "mlflow-postgres-subnet-group"
  subnet_ids = var.subnet_ids

  tags = var.terraform_tags
}

resource "random_password" "postgres_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_instance" "mlflow_postgres" {
  identifier             = "mlflow-postgres"
  engine                 = "postgres"
  engine_version         = "13.7"
  instance_class         = "db.t3.small"
  allocated_storage      = 20
  storage_type           = "gp2"
  db_name                = var.postgres_database
  username               = var.postgres_user
  password               = random_password.postgres_password.result
  db_subnet_group_name   = aws_db_subnet_group.mlflow_postgres.name
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]
  publicly_accessible    = false
  multi_az               = false

  tags = var.terraform_tags
}
