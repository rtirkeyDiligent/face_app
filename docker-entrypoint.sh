#!/bin/sh

set -e

# Run database migrations
echo "Running database migrations..."
bin/rails db:migrate

# Start the Rails server
echo "Starting Rails server..."
exec bin/rails server -b 0.0.0.0 -p 3000