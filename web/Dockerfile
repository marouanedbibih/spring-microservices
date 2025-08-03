# --------------------
# Stage 1: Base (shared dependencies)
# --------------------
FROM node:20-alpine AS base
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# --------------------
# Stage 2: Development
# --------------------
FROM base AS dev
RUN npm ci
COPY . .
EXPOSE 5173
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]

# --------------------
# Stage 3: Production Build
# --------------------
FROM base AS build
WORKDIR /app
COPY . .
RUN npm run build

# --------------------
# Stage 4: Production Runtime - SIMPLIFIED
# --------------------
FROM nginx:alpine AS prod

# Copy production build
COPY --from=build /app/dist /usr/share/nginx/html

# Remove default nginx config (will be replaced by ConfigMap)
RUN rm /etc/nginx/conf.d/default.conf

# Create placeholder for env.js (will be replaced by ConfigMap)
RUN echo 'window._env_ = {};' > /usr/share/nginx/html/env.js

EXPOSE 80

# Use default nginx command (no custom entrypoint needed)
CMD ["nginx", "-g", "daemon off;"]