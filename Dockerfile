FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html
COPY Photo.jpg /usr/share/nginx/html/Photo.jpg

EXPOSE 80
