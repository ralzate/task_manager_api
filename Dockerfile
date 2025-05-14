# Usa una imagen base oficial de Ruby
FROM ruby:3.0.0

# Instala dependencias del sistema necesarias para Rails y PostgreSQL
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn

# Define el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos necesarios para instalar las gemas
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copia el resto del código de la aplicación
COPY . .

# Asegura que no haya conflictos de PID al iniciar Rails
RUN mkdir -p tmp/pids

# Expone el puerto 3000 para que Rails sea accesible
EXPOSE 3000

# Comando por defecto al iniciar el contenedor
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
