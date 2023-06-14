# Capa base
FROM ubuntu:20.04 AS build

# Instalar dependencias necesarias
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
    git \
    curl \
    unzip \
    xz-utils \
    libglu1-mesa \
    lib32stdc++6 \
    lib32z1 \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*

# Crear un usuario no root
RUN groupadd -r flutter && useradd -r -g flutter flutter
USER flutter

# Directorio de trabajo en el contenedor
WORKDIR /home/flutter

# Descargar Flutter SDK
RUN git clone https://github.com/flutter/flutter.git .

# Agregar Flutter al PATH
ENV PATH="/home/flutter/bin:${PATH}"

# Configurar Flutter
RUN flutter config --no-analytics && flutter precache

# Directorio de trabajo en el contenedor para la aplicación
WORKDIR /app

# Copiar los archivos de la aplicación al contenedor
COPY . /app

# Etiqueta de versión de la aplicación
ARG APP_VERSION=1.0.0
LABEL version=${APP_VERSION}

# Nombre del repositorio remoto
ENV REMOTE_REPOSITORY=Emmanuelle20021/vitiumParaDocker
LABEL org.opencontainers.image.source=https://github.com/${REMOTE_REPOSITORY}
