# 1. Build Stage: Use the DHI Debian dev image to install tools and build your web assets
FROM dhi.io/php:8.5.8-debian13-dev AS builder

# Example: Install build tools and compile/prepare your web content
WORKDIR /app
COPY php.ini .


# 2. Final Stage: Copy the compiled site into a minimal production image
FROM dhi.io/php: 8.5.8-debian13-fpm

# Copy config files from the builder stage into production system
COPY --chown=65532:65532 --from=builder /app/php.ini /usr/local/apache2/conf/
COPY --chown=65532:65532 --from=builder /app/php.ini /usr/local/apache2/conf/


EXPOSE 9000

ENTRYPOINT ["/opt/php-8.5/sbin/php-fpm"]
