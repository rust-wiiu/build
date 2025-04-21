#!/bin/sh

if [ -z "$1" ]; then
  echo "Usage: clone <repo_names>"
  echo "       Clone rust-wiiu repositories from a single convenient command."
  echo "       Example: clone wut, wups, notifications"
  exit 1
fi

# Process each argument separately
for arg in "$@"; do
  # Split by comma and process each repository
  IFS=',' read -ra REPOS <<< "$arg"
  for repo_name in "${REPOS[@]}"; do
    # Trim whitespace
    repo_name=$(echo "$repo_name" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    
    # Skip empty names
    if [ -z "$repo_name" ]; then
      continue
    fi
    
    repo_url="${GH}/${repo_name}.git"
    echo "Cloning: $repo_url"
    git clone "$repo_url"
    
    if [ $? -ne 0 ]; then
      echo "Error cloning $repo_url. Exiting."
      exit 1
    fi
  done
done

echo "Finished cloning all repositories."
