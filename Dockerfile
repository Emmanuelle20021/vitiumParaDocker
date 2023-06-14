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

# Cambiar los permisos del archivo pubspec.lock
USER root
RUN chmod a+r pubspec.lock

# Obtener las dependencias del proyecto Flutter
USER flutter
RUN flutter pub get

# Construir la aplicación Flutter
RUN flutter build apk --split-per-abi

# Capa final
FROM ubuntu:20.04

# Instalar dependencias necesarias para ejecutar la aplicación
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
    libglu1-mesa \
    lib32stdc++6 \
    lib32z1 \
    && rm -rf /var/lib/apt/lists/*

# Directorio de trabajo en el contenedor
WORKDIR /app

# Copiar el artefacto de construcción desde la capa de compilación al contenedor
COPY --from=build /app/build/app/outputs/flutter-apk/app-release.apk /app/app-release.apk

# Exponer el puerto en el que la aplicación escucha (si es necesario)
EXPOSE 8080

# Comando para ejecutar la aplicación cuando el contenedor se inicie (opcional)
CMD ["flutter", "run", "--release"]
