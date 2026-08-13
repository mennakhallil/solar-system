FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install --no-save chai@4.3.10 chai-http@4.4.0 mocha@10.2.0
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
