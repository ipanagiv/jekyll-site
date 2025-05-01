# Build the site locally
build:
    bundle exec jekyll build

# Serve the site locally
serve:
    bundle exec jekyll serve

# Build and run the Docker container
docker-up:
    docker-compose up --build

# Stop the Docker container
docker-down:
    docker-compose down

# Push changes to GitHub
push:
    git add .
    git commit -m "{{commit_message}}"
    git push origin main

# Pull latest changes from GitHub
pull:
    git pull origin main 