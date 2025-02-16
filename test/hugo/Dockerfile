# Use the official Hugo image
FROM debian:bullseye-slim

# Set the working directory inside the container
WORKDIR /src

# Create the necessary folder structure
RUN mkdir -p /src/content /src/layouts/_default

# Create the hugo.toml file

# Expose the port Hugo will run on
EXPOSE 1313

# Command to run Hugo's server
CMD ["hugo", "server", "--bind", "0.0.0.0", "--port", "1313"]
