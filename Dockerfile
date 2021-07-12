FROM node:16-slim as stage1
WORKDIR /app
COPY package*.json ./
RUN npm install

FROM node:16-slim 
ENV REACT_APP_BASE_URL=http://localhost:5000
ENV NODE_ENV=development
WORKDIR /app
COPY --from=stage1 /app /app
EXPOSE 3000
CMD ["npm", "start"]
