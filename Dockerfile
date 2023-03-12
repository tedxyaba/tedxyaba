# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.1.3
FROM ruby:$RUBY_VERSION-slim as base

LABEL fly_launch_runtime="rails"

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_PATH="vendor/bundle" \
    BUNDLE_WITHOUT="development:test"

# Update gems and preinstall the desired version of bundler
ARG BUNDLER_VERSION=2.3.26
RUN gem update --system --no-document && \
    gem install -N bundler -v ${BUNDLER_VERSION}

# Install packages needed to install nodejs
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl unzip && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install Node.js
ARG NODE_VERSION=19.3.0
RUN curl -fsSL https://fnm.vercel.app/install | bash && \
    /root/.local/share/fnm/fnm install $NODE_VERSION
ENV PATH=/root/.local/share/fnm/aliases/default/bin/:$PATH


# Throw-away build stage to reduce size of final image
FROM base as build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libpq-dev libvips

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle _${BUNDLER_VERSION}_ install && \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE=1fb76b79d751ba05b79788ee605abccec0261b5cfd227a10bda0a51f9fc775d61c8afe114f98152a835f79bc8d9d8690b8d7cf5c01cf80be82cab039c5cd703d ./bin/rails assets:precompile


# Final stage for app image
FROM base

# Install packages needed for deployment
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y imagemagick libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# # Run and own the application files as a non-root user for security
RUN useradd rails
USER rails:rails

# Copy built application from previous stage
COPY --from=build --chown=rails:rails /rails /rails

# Deployment options
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true"

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
