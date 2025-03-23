provider "aws" {
  region  = var.region
  profile = var.account
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access"
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Jenkins web access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-08b5b3a93ed654d19" # Amazon Linux 2023 (Verifique o ID correto para sua região)
  instance_type = "t2.medium"

  key_name      = "chave-ssh-dev"
  security_groups = [aws_security_group.jenkins_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo dnf update -y
              
              # Instalar Java 17 (recomendado para Jenkins)
              sudo dnf install -y java-17-amazon-corretto

              # Adicionar repositório do Jenkins
              sudo wget -O /etc/yum.repos.d/jenkins.repo \
                https://pkg.jenkins.io/redhat/jenkins.repo
              sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

              # Instalar Jenkins
              sudo dnf install -y jenkins

              # Iniciar e habilitar Jenkins na inicialização
              sudo systemctl enable --now jenkins 
              EOF

  tags = {
    Name = "Jenkins-Server"
  }
}

output "dns" {
  value = aws_instance.jenkins_server.public_dns
}