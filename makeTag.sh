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

export HOMEBREW_EDITOR="/bin/cat"

for file in *; do
  if [[ $file != "README.md" && $file != "src" && ${file: -3} != ".sh" ]]; then
	  rm /opt/homebrew/Library/Taps/homebrew/homebrew-core/Formula/$file.rb
    brew create https://github.com/JonasGoetz01/brew-scripts/archive/refs/tags/$latest_tag.tar.gz --set-name=$file > ../homebrew-jogo/$file.rb
  	rm /opt/homebrew/Library/Taps/homebrew/homebrew-core/Formula/$file.rb

	cd ../homebrew-jogo

	# Remove every line that starts with a #
	sed -E -e 's/[[:space:]]*#.*//' -e '/^[[:space:]]*$/d' "$file.rb" > "$file.tmp"

	sed '/test do/,/end/ d' "$file.tmp" > "$file.tmp2"

	# Replace the original file with the modified file
	rm $file.tmp
	mv "$file.tmp2" "$file.rb"

	sed -i '' '/def install/,/end/c\def install\n    bin.install "'"$file"'"\n  end' "$file.rb"

	cd ../brew-scripts
  fi
done



