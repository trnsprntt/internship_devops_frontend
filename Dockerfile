FROM node:16-slim as stage1
WORKDIR /app
COPY package*.json /app
RUN npm install

FROM node:16-slim 
WORKDIR /app
COPY --from=stage1 /app/node_modules /app/node_modules
ENV REACT_APP_BASE_URL=http://localhost:5000
ENV NODE_ENV=development
EXPOSE 3000
CMD ["npm", "start"]
