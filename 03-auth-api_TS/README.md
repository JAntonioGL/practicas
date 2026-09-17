# 02-Auth-API: Proyecto de Aprendizaje JS (Node.js & Express)

Este es un proyecto de prueba y aprendizaje enfocado en el desarrollo backend utilizando **JavaScript, Node.js y Express**. El objetivo principal es familiarizarse con la creación de APIs, estructuración de proyectos y contenerización.

> **Nota sobre el uso de IA:** En este proyecto está permitido el uso de Inteligencia Artificial como herramienta de apoyo (ej. autocompletado, consultas, refactorización), pero **no** para la generación completa de código (IA no generativa).

## 🏗️ Arquitectura y Tecnologías

- **Arquitectura:** Se plantea el uso del patrón **MVC (Modelo-Vista-Controlador)** para mantener el código organizado y escalable.
- **Entorno de Ejecución:** Node.js.
- **Framework:** Express.js.
- **Gestor de Paquetes:** `pnpm`. Se utiliza `pnpm` en lugar de `npm` por motivos de seguridad y eficiencia.
- **Base de Datos:** PostgreSQL 17.
- **Despliegue/Replicabilidad:** Contenedores Docker.

## 🚀 Funcionalidades Actuales

Por el momento, el sistema cuenta con las siguientes funcionalidades básicas:
- Búsqueda/Consulta de usuarios.
- Registro de un nuevo usuario en el sistema.

*Nota Histórica: Existe una versión temprana (ya obsoleta) del proyecto que utilizaba un archivo `.json` como base de datos de prueba. La versión activa y que recibirá actualizaciones es la que se implementa con Docker y PostgreSQL.*

## 📋 Requisitos Previos

Para poder ejecutar este proyecto, es **estrictamente necesario** tener instalado lo siguiente en tu sistema:
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (o el motor de Docker correspondiente).

## ⚙️ Configuración del Entorno

Antes de levantar el proyecto, necesitas configurar las variables de entorno:

1. Crea un archivo llamado `.env` en la raíz del proyecto (`02-auth-api`).
2. Copia el contenido del archivo `.env.demo` hacia tu nuevo archivo `.env`.
3. Ajusta los valores de las variables en el `.env` según sea necesario para tu entorno local.

## 🐳 Ejecución con Docker (Especial para Windows)

El archivo `docker-compose.yml` está diseñado y optimizado específicamente para entornos **Windows**. 

Debido a conflictos comunes con el puente de red y el uso de volúmenes en Windows, el enrutamiento se ha configurado de manera manual. Esto permite que el *watchdog* de `nodemon` funcione correctamente, detectando los cambios en el código y reiniciando el servidor automáticamente **sin necesidad de tirar o reconstruir la imagen de Docker**.

### Comandos Útiles

- **Iniciar el proyecto (modo interactivo):**
  ```bash
  docker compose up
  ```

- **Iniciar el proyecto en segundo plano (detached) forzando la reconstrucción:**
  ```bash
  docker compose up -d --build
  ```

- **Ver los logs de la aplicación en tiempo real:**
  Para ver únicamente los registros del contenedor de la API (útil si lo corriste en segundo plano):
  ```bash
  docker logs -f api_node24_experimentojs
  ```
