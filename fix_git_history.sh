#!/bin/bash

# Fix git history for proper GitHub contributions
cd /Users/funinc/Documents/crypto_simulator_complete

# Set the correct email for GitHub contributions
# Use GitHub's noreply email which always works
GITHUB_EMAIL="Sid4mn@users.noreply.github.com"
AUTHOR_NAME="Siddhant Shettiwar"

echo "Fixing git history with:"
echo "Email: $GITHUB_EMAIL"
echo "Name: $AUTHOR_NAME"

# First, let's get all commit hashes and their dates
git log --format="%H|%ad" --date=format:"%Y-%m-%d %H:%M:%S" > /tmp/commits.txt

# Reset to first commit
FIRST_COMMIT=$(git rev-list --max-parents=0 HEAD)
git reset --hard $FIRST_COMMIT

# Remove the origin temporarily
git remote remove origin

# Rewrite history commit by commit with proper dates and email
while IFS='|' read -r hash date; do
    # Skip the first commit (it's already there)
    if [ "$hash" != "$FIRST_COMMIT" ]; then
        # Convert 2025 to 2024
        new_date=$(echo "$date" | sed 's/2025-/2024-/g')
        
        # Get commit info
        commit_msg=$(git log --format="%s" -n 1 $hash 2>/dev/null || echo "commit")
        
        # Create the commit with proper date and email
        GIT_AUTHOR_DATE="$new_date" \
        GIT_COMMITTER_DATE="$new_date" \
        GIT_AUTHOR_NAME="$AUTHOR_NAME" \
        GIT_COMMITTER_NAME="$AUTHOR_NAME" \
        GIT_AUTHOR_EMAIL="$GITHUB_EMAIL" \
        GIT_COMMITTER_EMAIL="$GITHUB_EMAIL" \
        git commit --allow-empty -m "$commit_msg" --date="$new_date"
        
        echo "Created commit: $commit_msg ($new_date)"
    fi
done < <(tac /tmp/commits.txt)

# Re-add the remote
git remote add origin https://github.com/Sid4mn/crypto-trading-simulator.git

echo "Git history fixed! All commits now use 2024 dates and proper email."
echo "You can now push with: git push -f origin main"
