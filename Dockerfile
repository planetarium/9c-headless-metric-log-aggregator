FROM rust:latest AS build-env
WORKDIR /app

# Copy everything from the current directory into the container
COPY . .

# Build the project
RUN cargo build --release

# Build runtime image
FROM rust:latest
WORKDIR /app

COPY --from=build-env --chown=user:group /app/target/release/nc-headless-metric-log-aggregator .

ENTRYPOINT ["./nc-headless-metric-log-aggregator"]