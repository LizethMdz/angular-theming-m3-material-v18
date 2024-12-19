# Stage 1: Build
FROM node:20-alpine AS build
# Directorio donde se mantendran los archivos de la app
WORKDIR /usr/src/app

COPY . /usr/src/app

RUN npm install -g @angular/cli@18.0.0

RUN npm install

CMD ["ng", "serve", "--host", "0.0.0.0"]

# Copiar todos los archivos
#COPY . .
# Construir la aplicacion lista para produccion, puede no incluir el # flag --prod
#RUN npm run build

# Stage 2
#FROM nginx:1.17.1-alpine

# Copiar desde la "Etapa" build el contenido de la carpeta build/
# dentro del directorio indicado en nginx

#COPY --from=build /usr/src/app/dist/app-material /usr/share/nginx/html

# Copiar desde la "Etapa" build el contenido de la carpeta la 
# configuracion de nginx dentro del directorio indicado en nginx
#COPY --from=build /usr/src/app/nginx.conf /etc/nginx/conf.d/default.conf

#EXPOSE 80