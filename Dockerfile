FROM golang:1.16-alpine

USER nobody

RUN mkdir -p /opt/weatherapp/api
WORKDIR /opt/weatherapp/api

COPY . /opt/weatherapp/api
RUN go build

CMD ["./api"]