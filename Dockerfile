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


FROM node:20-alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install -g @angular/cli@18.0.0
RUN npm install
COPY . ./
RUN npm run build
EXPOSE 8080
CMD [ "node", "server.js" ]