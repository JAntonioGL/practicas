FROM node:24-alphine

RUN corepack enable pnpm

WORKDIR /app

COPY . .

run pnpm install --ignore-scripts

EXPOSE 3000

CMD ["pnpm","run","dev"]

