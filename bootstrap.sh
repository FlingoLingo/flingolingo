#!/bin/bash

# Tells the shell script to exit if it encounters an error
set -e

# Error handling
log_bootstrap_not_finished() {
    log_error "Bootstrap finished with error. Please read output, fix it and run bootstrap.sh again"
}

# Checks if executable exists in current path
command_exists () {
  command -v "$1" > /dev/null 2>&1;
}

# Logging

function log {
    echo -e "\033[0m➜ $1"
}
function log_ok {
    echo -e "\033[92m✔ $1"
    echo "--------------------------------------------------------"
}
function log_warn {
    echo -e "\033[0;33mWarning: $1"
    echo "--------------------------------------------------------"
}
function log_info {
    echo -e "\033[0m\033[7mInfo: $1"
}

function log_error {
    echo -e "\033[0;31m× Error: $1"
    echo "--------------------------------------------------------"
}

# Stages

function homebrew_install {
    log "Homebrew installation started."
    if ! command_exists brew
    then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Checking brew install. Because you need to call some commands after install on MacBook with M1.
        if ! command_exists brew
        then
            log_error "Brew installation was not finished.\nPlease read brew installation output and follow Next steps.\nThen run bootstrap.sh again"
            exit 1
        fi
    else
        log "Homebrew already installed. Starting brew update"
        brew update
    fi
    log_ok "Homebrew successfully installed."
}

function rbenv_install {
    log "rbenv installation started."
    if ! command_exists rbenv
    then
        brew install rbenv
    fi
    eval "$(rbenv init -)"
    log_ok "rbenv successfully installed."
}

function zshrc_change {
    if ! grep -Fxq 'eval "$(rbenv init -)"' ~/.zshrc
    then
        echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    fi
}

function bash_profile_change {
    if ! grep -Fxq 'eval "$(rbenv init -)"' ~/.bash_profile
    then
        echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    fi
}

function ruby_install {
    log "Ruby installation started."
    pwd
    ruby_version="$(cat .ruby-version)"
    log "Target ruby version is ${ruby_version}"
    log "Current ruby -v: $(ruby -v)"
    OPENSSL_CFLAGS=-Wno-error=implicit-function-declaration rbenv install "${ruby_version}" -s
    log_ok "Ruby successfully installed."
}

function bundler_install {
    log "Bundler installation started."
    bundler_version="$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"
    gem install bundler -v "${bundler_version}"
    bundle install
    log_ok "Bundler successfully installed."
}

function pods_install {
    log "CocoaPods installation started."
    bundle exec pod install
    log_ok "CocoaPods successfully installed."
}

function bootstrap {
    log "bootstrap started!"
    
    # path from which we started executing
    from_path=$(pwd)
    
    # setup in project_folder
    #homebrew_install
    rbenv_install
    zshrc_change
    bash_profile_change
    ruby_install
    bundler_install
    pods_install
    
    # go to path from which we started executing
    cd ${from_path}

    log_ok "bootstrap successfully finished!"
}

trap log_bootstrap_not_finished EXIT

bootstrap

exec $SHELL
