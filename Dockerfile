#FROM nexus.elm.sa/golang:1.16-alpine AS build

#WORKDIR /src/
#COPY main.go go.* /src/
#RUN CGO_ENABLED=0 go build -o /opt/app

#FROM scratch
#COPY --from=build /opt/app /opt/app
#ENTRYPOINT ["/opt/app"]

FROM nexus.elm.sa/golang:1.16-alpine

USER nobody

RUN mkdir -p /opt/weatherapp/api
WORKDIR /opt/weatherapp/api

COPY . /opt/weatherapp/api
RUN go build

CMD ["./api"]