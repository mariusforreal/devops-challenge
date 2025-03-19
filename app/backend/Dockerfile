FROM node:16-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Update the frontend URL environment variable
ARG FRONTEND_URL
ENV FRONTEND_URL=${FRONTEND_URL}

EXPOSE 8080

CMD ["npm", "start"]
