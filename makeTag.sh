#!/bin/zsh


	./spinner.sh "./prepareFiles.sh" "Prepare files"
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
    	brew create https://github.com/JonasGoetz01/brew-scripts/archive/refs/tags/$new_tag.tar.gz --set-name=$file > ../homebrew-jogo/$file.rb
  		rm /opt/homebrew/Library/Taps/homebrew/homebrew-core/Formula/$file.rb

		cd ../homebrew-jogo

		# Remove every line that starts with a #
		sed -E -e 's/[[:space:]]*#.*//' -e '/^[[:space:]]*$/d' "$file.rb" > "$file.tmp"

		sed '/test do/,/end/ d' "$file.tmp" > "$file.tmp2"

		# Replace the original file with the modified file
		rm $file.tmp
		mv "$file.tmp2" "$file.rb"

		sed -i '' 's/system "\.\/configure", \*std_configure_args, "--disable-silent-rules"/bin.install "'"$file"'"/g' "$file.rb"
		sed -i '' -n '/^class/,$p' "$file.rb"
		cd ../brew-scripts
  	fi
	done

	cd ../homebrew-jogo
	git add .
	git commit -m "automated commit by makeTag.sh"
	git push


	cd ../brew-scripts
	for file in *; do
  	if [[ $file != "README.md" && $file != "src" && ${file: -3} != ".sh" ]]; then
	  	rm $file
  	fi
	done


	git add .
	git commit -m "cleanup"
	git push


#./spinner.sh "scriptsPushen" "Push scripts"
#./spinner.sh "tagErstellen" "Create tag"
#./spinner.sh "formulaErstellen" "Create formulas"
#./spinner.sh "updateFormulaRepo" "Update Formula repository"
#./spinner.sh "cleanup" "Cleanup"
#./spinner.sh "pushCleanup" "Push clean repository"
