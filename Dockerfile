# # Stage 1: Build
# FROM node:20-alpine AS build
# # Directorio donde se mantendran los archivos de la app
# WORKDIR /app

# COPY package*.json ./

# RUN npm install


# # Copiar todos los archivos
# COPY . .
# # Construir la aplicacion lista para produccion, puede no incluir el # flag --prod
# RUN npm run build

# # Stage 2
# FROM nginx:alpine

# # Copiar desde la "Etapa" build el contenido de la carpeta build/
# # dentro del directorio indicado en nginx

# COPY --from=build /app/dist/app-material/browser /usr/share/nginx/html

# # Copiar desde la "Etapa" build el contenido de la carpeta la 
# # configuracion de nginx dentro del directorio indicado en nginx
# #COPY --from=build /usr/src/app/nginx.conf /etc/nginx/conf.d/default.conf

# EXPOSE 8080

# CMD ["nginx", "-g", "daemon off;"]


# STAGE 1: Build

FROM node:20-alpine as builder

COPY package.json package-lock.json ./

RUN npm ci && mkdir /app && mv ./node_modules ./app

WORKDIR /app

COPY . .

RUN npm run ng build -- --prod

# STAGE 2: Deploy

FROM nginx:1.17-alpine

COPY nginx/default.conf.template /etc/nginx/conf.d/

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/dist/app-material/browser /usr/share/nginx/html

COPY run.sh /

CMD ["/run.sh"]