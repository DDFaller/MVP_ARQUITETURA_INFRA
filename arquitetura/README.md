
# MVP Arquitetura

Este repositório contém a configuração de todos os componentes da aplicação MVP Arquitetura, incluindo o banco de dados, backend em Python, API em Express.js e frontend em React.

## Sumário

- [Instalação](#instalação)
- [Configuração](#configuração)
- [Uso](#uso)
- [Docker Compose](#docker-compose)

## Instalação

### Pré-requisitos

- Docker
- Docker Compose

### Passos

1. Clone o repositório:

```bash
git clone https://github.com/DDFaller/MVP_Arquitetura.git
cd MVP_Arquitetura
```

## Configuração

Certifique-se de que os arquivos `.env` estão corretamente configurados para seu ambiente em cada subdiretório (`back`, `s3`, `front`).

Exemplo de arquivo `.env`:

```env
#S3 api
AWS_ACCESS_KEY_ID='AKIATHRQUE3TJXG7QPPQ'
AWS_SECRET_ACCESS_KEY='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'
AWS_REGION='us-east-1'
S3_BUCKET_NAME='mvp-s3'
THIRD_PARTY_API_URL='http://python-backend:5000/'


#Python API
S3_COMMUNICATION_API='http://express-api:3003/'
DATABASE_URL='postgresql://postgres:0812@db:5432/mvp'
```

## Uso

### Iniciar a Aplicação

Para iniciar todos os serviços, use:

```bash
docker-compose up -d
```

### Parar a Aplicação

Para parar todos os serviços, use:

```bash
docker-compose down
```

## Docker Compose

### Estrutura do `docker-compose.yml`

```yaml
version: '3.8'

services:
  db:
    image: postgres
    restart: always
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=0812
    ports:
      - 5432:5432
    volumes:
      - ./postgres-data:/var/lib/postgresql/data
      - ./db-init:/docker-entrypoint-initdb.d
    networks:
      - backend

  python-backend:
    build: ./back
    ports:
      - "5000:5000"
    env_file:
      - .env
    depends_on:
      - db
    networks:
      - frontend
      - backend

  express-api:
    build: ./s3
    ports:
      - "3003:3003"
    env_file:
      - .env
    depends_on:
      - db
    networks:
      - frontend
      - backend

  react-app:
    build: ./front
    ports:
      - "3000:80"
    env_file:
      - .env
    depends_on:
      - express-api
      - python-backend
    networks:
      - frontend

  adminer:
    image: adminer
    restart: always
    ports:
      - 8080:8080

networks:
  backend:
    driver: bridge
  frontend:
    driver: bridge
```

### Estrutura de Diretórios

Certifique-se de que os diretórios estejam estruturados da seguinte forma:

```
MVP_Arquitetura/
├── back/
│   ├── Dockerfile
│   ├── app.py
│   ├── requirements.txt
│   └── ...
├── s3/
│   ├── Dockerfile
│   ├── server.js
│   ├── package.json
│   └── ...
├── front/
│   ├── Dockerfile
│   ├── src/
│   ├── public/
│   └── ...
├── postgres-data/
├── db-init/
│   └── create_tables.sql
├── docker-compose.yml
└── README.md
```