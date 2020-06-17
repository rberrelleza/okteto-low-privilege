FROM golang:buster as builder
WORKDIR /app
COPY go.mod .
COPY main.go .
ENV CGO_ENABLED=true
ENV LDFLAGS='-extldflags "-static"'
RUN go build -o hey .

FROM debian:buster

RUN addgroup --gid 1000 app
RUN adduser --uid 1000 --gid 1000 -u 1000 app
COPY --from=builder /app/hey /app/hey
EXPOSE 8080
CMD ["/app/hey"]