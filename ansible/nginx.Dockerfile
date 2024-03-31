FROM nginx:latest

# Видаляємо default конфігурацію та додаємо нашу
RUN rm /etc/nginx/conf.d/default.conf
COPY example.com.conf /etc/nginx/conf.d/

# Вказуємо Nginx слухати порт 80
EXPOSE 80