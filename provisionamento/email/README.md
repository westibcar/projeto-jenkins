### 📘 Como usar

1. **Salve o arquivo** abaixo como `docker-compose.yml` no seu projeto:

   ```yaml
   version: '3.8'

   services:
     mailhog:
       image: mailhog/mailhog
       container_name: mailhog
       ports:
         - "1025:1025"   # Porta SMTP
         - "8025:8025"   # Interface web para visualizar os e-mails
   ```

2. **Suba o serviço com Docker Compose**:

   ```bash
   docker-compose up -d
   ```

3. **Configure sua aplicação ou script para enviar e-mails com os seguintes dados SMTP**:

   - **SMTP host:** `localhost`
   - **SMTP port:** `1025`
   - **Usuário/Senha:** *não é necessário para testes com MailHog*

4. **Acesse a interface web do MailHog para visualizar os e-mails enviados**:

   👉 [http://localhost:8025](http://localhost:8025)