FROM nexus.elm.sa/golang:1.16-alpine AS build

WORKDIR /src/
COPY main.go go.* /src/
RUN CGO_ENABLED=0 go build -o /opt/app

FROM scratch
COPY --from=build /opt/app /opt/app
ENTRYPOINT ["/opt/app"]