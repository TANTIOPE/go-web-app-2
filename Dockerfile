# First stage: build the Go app
FROM golang:1.22.5 AS builder

WORKDIR /app

# Copy go.mod and go.sum files to download dependencies
COPY go.mod . 
# Download dependencies
RUN go mod download

# Copy the source code
COPY . .

# Build the Go binary
RUN GOOS=linux GOARCH=amd64 go build -o main .

# Second stage: distroless
FROM gcr.io/distroless/base

# Copy the compiled binary from the builder stage
COPY --from=builder /app/main /main

# Copy any necessary static files (if needed)
COPY --from=builder /app/static /static

# Expose the required port
EXPOSE 8080

# Command to run the Go binary
CMD ["/main"]
