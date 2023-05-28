# Use the official Golang image to create a build artifact.
# This is based on Debian and sets the GOPATH to /go.
# https://hub.docker.com/_/golang
FROM golang:1.17 as builder

# Copy local code to the container image.
WORKDIR /app
COPY main.go .
COPY go.mod .

# Download dependencies
RUN go mod download

# Build the command inside the container.
# You may also want to retrieve dependencies with 'go get'.
# RUN go get -d -v ./...
RUN CGO_ENABLED=0 GOOS=linux go build -v -o myapp

# Create a new stage with user and group
FROM golang:1.17

# make user in container same as localhost user
ARG MY_UID
ARG MY_GID
RUN groupadd -g $MY_GID appuser && \
  useradd -u $MY_UID -g $MY_GID -m appuser \
  && echo "appuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Copy the binary from builder stage to this user stage
COPY --from=builder /app/myapp /home/appuser/bin/myapp
RUN chown -R appuser:appuser /home/appuser

# Change appuser, same UID of localhost user
USER appuser
# Set the work directory
WORKDIR /home/appuser/bin

# Run myapp on container startup.
CMD ["/bin/bash", "-c", "./myapp && tail -f /dev/null"]

