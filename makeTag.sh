#!/bin/zsh

git add .
git commit -m "automated commit by makeTag.sh"
git push

# Fetch the latest tag name
latest_tag=$(git describe --tags --abbrev=0)

# Increment the version number
new_tag=$(echo $latest_tag | awk -F. '{$NF = $NF + 1;} 1' | sed 's/ /./g')

# Create the new tag
git tag $new_tag

# Push the new tag to the remote repository
git push -u origin $new_tag

for file in *; do
  if [[ $file != "README.md" && $file != "src" && ${file: -3} != ".sh" ]]; then
    brew create https://github.com/JonasGoetz01/brew-scripts/archive/refs/tags/$latest_tag.tar.gz --tap=$file
  	mv /opt/homebrew/Library/Taps/homebrew/homebrew-core/Formula/$file.rb ./$file.rb
  fi
done



