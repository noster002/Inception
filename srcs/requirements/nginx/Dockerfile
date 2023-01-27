FROM		alpine:3.16

RUN			apk add --no-cache nginx && \
			mkdir -p /etc/nginx/ssl /var/www/html/wordpress

COPY		tools /etc/nginx/ssl
COPY		conf/nosterme.42.fr.conf /etc/nginx/http.d/nosterme.42.fr.conf

CMD			["/usr/sbin/nginx", "-g", "daemon off;"]
