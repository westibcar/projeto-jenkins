## Parar a Instância

```bash
aws ec2 stop-instances --instance-ids i-xxxxxxxxxxxxxxxxx --profile account_terraform
```

## Iniciar a Instância

```bash
aws ec2 start-instances --instance-ids i-xxxxxxxxxxxxxxxxx --profile account_terraform
```

### NOTA:  
No meu caso, configurei um profile específico para uso com o Terraform. Se você não configurou um profile, basta executar o comando sem a opção `--profile`, assim:

```bash
aws ec2 start-instances --instance-ids i-xxxxxxxxxxxxxxxxx
```




