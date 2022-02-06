FROM golang:1.16-alpine

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /docker-gs-ping

RUN groupadd -r appuser && adduser appuser
USER appuser

EXPOSE 8080

CMD [ "/docker-gs-ping" ]