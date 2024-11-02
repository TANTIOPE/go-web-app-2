# Stage 1: Build the Go application
FROM golang:1.22 as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the Go application binary for Linux
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o hello-world-app main.go

# Stage 2: Create the final Distroless image
FROM gcr.io/distroless/static-debian11

# Copy the binary from the builder stage
COPY --from=builder /app/hello-world-app /hello-world-app

# Expose port 8080 for the application
EXPOSE 8080

# Run the application
ENTRYPOINT ["/hello-world-app"]
