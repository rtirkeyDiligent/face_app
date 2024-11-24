# Use the official Ruby image as a base
FROM ruby:3.3

# Install Node.js and Yarn
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install --global yarn

# Set working directory
WORKDIR /app

# Copy Gemfile and install Ruby dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy package.json and install Node.js dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Copy all project files
COPY . .

# Expose ports
EXPOSE 3000 3036

# Run a custom entrypoint script for migrations and server start
ENTRYPOINT ["sh", "/app/docker-entrypoint.sh"]