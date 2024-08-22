# use the base go image as the base
# this provides everything that is needed
# to build the Go app
FROM golang:1.21.10-alpine as builder

# run mkdir inside the container
RUN mkdir /app

# copy everything in the current dir to /app
COPY . /app

# set the working directory
WORKDIR /app

# set env var
# we are not using any c library, so set this to 0
RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api

# add executable flag (just to make sure it is actually executable)
RUN chmod +x /app/brokerApp

# this stage uses a minimal Alpine Linux Image
# This image is is very small and efficient to run applications
FROM alpine:latest

RUN mkdir /app

# copy the compiled binary from the builder stage to this new stage
COPY --from=builder /app/brokerApp /app

# specify the command to run the app
CMD [ "/app/brokerApp" ]