FROM node:24-alpine3.23

RUN corepack enable pnpm

WORKDIR /home/app

COPY . .

RUN pnpm install --ignore-scripts

EXPOSE 3000

CMD ["pnpm", "run", "dev"]