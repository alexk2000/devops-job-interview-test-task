FROM nginx:latest
ARG CI_COMMIT_SHA
RUN echo $CI_COMMIT_SHA > /usr/share/nginx/html/index.html
