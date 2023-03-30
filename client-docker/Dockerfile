FROM node:lts-alpine3.17 AS build

WORKDIR /app

RUN apk update
RUN apk add git
RUN git clone https://github.com/jefftb540/autoatendimento.git

RUN sh -c "cd autoatendimento && npm install"

RUN sh -c "cd autoatendimento && npm run build"

FROM nginx:alpine

COPY --from=build /app/autoatendimento/build /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf
COPY ./to-copy/nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
