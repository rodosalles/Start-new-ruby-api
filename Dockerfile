# Use uma imagem base com Ruby 2.7
FROM ruby:2.7

# Instale as dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Configure o ambiente Rails
ENV RAILS_ENV=development

# Crie o diretório de trabalho na imagem
WORKDIR /myapp

# Instale o Rails
RUN gem install rails -v 5.2.0

# Crie uma nova aplicação Rails
RUN rails new . --database=postgresql

# Copie o Gemfile e o Gemfile.lock para o diretório de trabalho
COPY Gemfile Gemfile.lock ./

# Instale as gems
RUN gem install bundler
RUN bundle install

# Copie o restante do código fonte da sua aplicação para a imagem
COPY . .

# Configure o banco de dados PostgreSQL
# Certifique-se de que as informações de configuração do banco de dados
# estejam corretamente definidas no arquivo config/database.yml


# Exponha a porta em que o servidor Rails será executado
EXPOSE 3000

# Inicie o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
