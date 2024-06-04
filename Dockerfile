FROM caddy:2.8.1-alpine

WORKDIR /public

# Copy index.html to the container
COPY index.html .

# Update Caddy Config location
COPY Caddyfile /etc/caddy/Caddyfile

# Setting up labels
LABEL org.opencontainers.image.title="CSYE 7125 Static Site"
LABEL org.opencontainers.image.description="CSYE7125 Static Site hosted with Caddy"

# Set Environment Variables
ENV CADDY_PORT=8080
ENV CADDY_ADDRESS=:$CADDY_PORT

# Expose the port
EXPOSE $CADDY_PORT
