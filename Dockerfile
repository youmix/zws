FROM node:15.12.0-alpine3.10

WORKDIR /usr/src/app

ENV PORT=3000
EXPOSE 3000

RUN apk add curl

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD curl -X GET --fail http://localhost:3000/health || exit 0

COPY package.json yarn.lock .yarnrc.yml tsconfig.json ./
COPY prisma ./prisma
COPY .yarn ./.yarn
COPY src ./src
COPY types ./types

RUN yarn install --immutable
RUN yarn prisma generate
RUN yarn build

# Remove devDependencies manually, Yarn 2 doesn't support skipping them (see https://yarnpkg.com/configuration/manifest#devDependencies)
RUN yarn remove @semantic-release/exec @tsconfig/node14 @types/node @types/supports-color cli-ux eslint-plugin-prettier prettier prettier-config-xo semantic-release semantic-release-docker ts-json-schema-generator ts-node type-fest typescript xo
RUN yarn install --immutable
RUN rm -rf .yarn/cache src tsconfig.json

CMD ["node", "."]
