# A collection of environment variables to be set

# Jekyll
set -gx JEKYLL_ENV development

# Set locale for SSH connections
set -gx LC_ALL en_US.UTF-8  
set -gx LANG en_US.UTF-8

# Skip fastlane update check
set -gx FASTLANE_SKIP_UPDATE_CHECK 1
