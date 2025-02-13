FROM golang:1.22 AS builder
WORKDIR /app
COPY api/go.mod api/go.sum ./
RUN go mod download
COPY api/ .
RUN go build -o main .

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/main .
EXPOSE 3001

CMD ["./main"]