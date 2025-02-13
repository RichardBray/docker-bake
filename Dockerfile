FROM oven/bun:1.2-slim AS base
WORKDIR /usr/app/app

FROM base AS install
RUN mkdir -p /temp/prod
COPY package.json bun.lock /temp/prod/
RUN cd /temp/prod && bun install --frozen-lockfile --production

FROM base AS prerelease
COPY --from=install /temp/prod/node_modules node_modules
COPY . .

FROM base AS release
COPY --from=install /temp/prod/node_modules node_modules
COPY --from=prerelease /usr/app/app/app ./app
COPY --from=prerelease /usr/app/app/package.json .

USER bun
EXPOSE 3000/tcp
ENTRYPOINT [ "bun", "run", "app/index.ts" ]