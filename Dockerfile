FROM golang:1.16-alpine3.15 AS builder
WORKDIR /usr/weatherapp
COPY . .
RUN go mod download
RUN go build -o api main.go

FROM alpine:3.15
WORKDIR /usr/weatherapp

COPY --from=builder /usr/weatherapp/api .

RUN adduser -D appuser && chown -R appuser /usr/weatherapp
USER appuser

EXPOSE 8080

CMD ["/usr/weatherapp/api"]