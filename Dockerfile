# ---------- Stage 1: builder ----------
# Node.js (pinned tag) is used ONLY to build the static site
FROM node:22-alpine AS builder

# Working directory inside the build container
WORKDIR /app

# Copy only dependency manifests first so the npm layer is cached
COPY package*.json ./

# Clean, reproducible install from package-lock.json
RUN npm ci

# Copy the website sources (changes here do not invalidate the npm layer)
COPY src/ ./src/
COPY styles/ ./styles/

# Build all HTML pages into /app/dist
RUN npm run build

# ---------- Stage 2: runtime ----------
# Small Nginx image (pinned tag) that serves the static files
FROM nginx:1.27-alpine

# Copy ONLY the built site from the builder stage (no Node.js, no node_modules)
COPY --from=builder /app/dist /usr/share/nginx/html

# Document the port Nginx listens on
EXPOSE 80

# Run Nginx in the foreground so the container stays alive
CMD ["nginx", "-g", "daemon off;"]
