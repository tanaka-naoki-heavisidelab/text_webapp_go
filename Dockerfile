# Use the official Golang image.
# https://hub.docker.com/_/golang
FROM golang:1.17

# make user in container same as localhost user
ARG MY_UID
ARG MY_GID
RUN groupadd -g $MY_GID appuser && \
  useradd -u $MY_UID -g $MY_GID -m appuser \
  && echo "appuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Change appuser, same UID of localhost user
USER appuser

# Set the work directory
WORKDIR /home/appuser/app

# Keep app container running.
CMD ["/bin/bash", "-c", "tail -f /dev/null"]