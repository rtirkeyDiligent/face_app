# Use the official Ruby image as a base
FROM ruby:3.3

# Install Node.js and Yarn
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update && apt-get install -y nodejs && \
    npm install --global yarn

# Set working directory
WORKDIR /app

# Install Ruby and Node.js dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install

# Copy the rest of the application code
COPY . .

# Expose ports
EXPOSE 3000 3036