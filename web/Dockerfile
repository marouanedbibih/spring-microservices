# --------------------
# Stage 1: Base (shared dependencies)
# --------------------
FROM node:20-alpine AS base
WORKDIR /app
COPY package*.json ./
RUN npm install --legacy-peer-deps

# --------------------
# Stage 2: Development
# --------------------
FROM base AS dev
WORKDIR /app
COPY . .
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]

# --------------------
# Stage 3: Production Build
# --------------------
FROM base AS build
WORKDIR /app
COPY . .
RUN npm run build

# --------------------
# Stage 4: Production Runtime
# --------------------
FROM nginx:alpine AS prod

# Copy production build
COPY --from=build /app/dist /usr/share/nginx/html

# Add a template env.js (will be overwritten by entrypoint)
COPY docker/env.template.js /usr/share/nginx/html/env.js

# Add custom nginx config (optional but recommended)
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

# Add entrypoint to inject env vars at runtime
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
