# Use uma imagem base oficial do Python. A versão slim é menor e ideal para produção.
FROM python:3.10-slim

# Defina o diretório de trabalho no contêiner para organizar os arquivos.
WORKDIR /app

# Copie o arquivo de dependências primeiro.
# Isso aproveita o cache de camadas do Docker: se o requirements.txt não mudar,
# as dependências não serão reinstaladas em builds futuros, acelerando o processo.
COPY requirements.txt .

# Instale as dependências. A flag --no-cache-dir reduz o tamanho final da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Copie o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Exponha a porta em que o Uvicorn será executado dentro do contêiner.
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar.
# Usamos --host 0.0.0.0 para que a aplicação seja acessível de fora do contêiner,
# e não apenas de localhost (dentro do contêiner).
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]