# builder image
FROM golang:1.17.1-alpine3.14 AS sqs2go-examples-producer-builder

RUN mkdir /build

COPY *.go /build/
COPY go.mod /build/
COPY go.sum /build/

WORKDIR /build

RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -o producer .


# final image
FROM alpine:3.14 AS producer

COPY --from=sqs2go-examples-producer-builder /build/producer .

CMD ./producer --endpoint=$ENDPOINT --url=$URL