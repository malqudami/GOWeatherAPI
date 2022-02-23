FROM golang:1.16-alpine

RUN mkdir -p /weatherapp/api

RUN adduser -D appuser && chown -R appuser /weatherapp/api
USER appuser

COPY . /weatherapp/api

WORKDIR /weatherapp/api

RUN go build

CMD ["./api"]