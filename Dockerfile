FROM caddy:2.8.1-alpine

# Copy the folder to the container
WORKDIR /public
COPY . .

# Update Caddy Config location
RUN ["mv", "Caddyfile", "/etc/caddy/Caddyfile"]

# Set Environment Variables
ENV CADDY_PORT=8080
ENV CADDY_ADDRESS=:$CADDY_PORT

# Expose the port
EXPOSE $CADDY_PORT

# Start the server
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]

