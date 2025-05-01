FROM ruby:3.2-slim

WORKDIR /srv/jekyll

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Jekyll
COPY Gemfile .
RUN bundle install

# Copy site contents
COPY . .

# Build the site
RUN bundle exec jekyll build

# Set environment variables
ENV JEKYLL_ENV=production
ENV LANG=C.UTF-8

# Expose port 4000
EXPOSE 4000

# Start Jekyll server with the built site
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000", "--watch", "--force_polling", "--source", "/srv/jekyll", "--destination", "/srv/jekyll/_site"] 