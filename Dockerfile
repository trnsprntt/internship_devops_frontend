FROM node:16-slim as stage1
WORKDIR /app
COPY package*.json ./
RUN npm install

FROM node:16-slim as stage2
WORKDIR /app
COPY --from=stage1 /app/node_modules /app/node_modules
COPY . /app
ARG REACT_APP_BASE_URL=""
RUN npm run build

FROM nginx:latest
COPY --from=stage2 /app/nginx/ /etc/nginx/templates
COPY --from=stage2 /app/build /usr/share/nginx/html
ENV REACT_APP_BASE_URL=http://localhost:5000
ENV NODE_ENV=development
EXPOSE 3000
