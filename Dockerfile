FROM golang:1.17

WORKDIR /usr/weatherapp/api

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .
RUN go build -v -o /usr/weatherapp/api ./...

RUN adduser -D appuser && chown -R appuser /usr/weatherapp/api
USER appuser

CMD ["api"]