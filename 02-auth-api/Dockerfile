#usar node24
FROM node:24-alpine3.23 
#habilita pnpm nativo despues de node 22
RUN corepack enable pnpm
#establece el directorio de trabajo
WORKDIR /home/app
#copia todo mi espacio de trabajo en la raiz del directorio en docker
COPY . .
#corre pnpm install ignorando scripts para instalar dependencias (nodemon, bcrypt, etc)
RUN pnpm install --ignore-scripts
#expon el puerto 3000
EXPOSE 3000
#este comando es para correr el server "pnpm run dev" (revisar en package.json)
CMD ["pnpm", "run", "dev"]