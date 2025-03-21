alias bu "brew update && brew upgrade && brew cleanup"
alias certs "env MATCH_KEYCHAIN_PASSWORD=(read -s) bundle exec fastlane certificates"
alias pr "git push origin HEAD && open (gh pr create -f)"
