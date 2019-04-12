# Mac Setup for local development

This install is done with Mojave: 10.14.4 and should get a clean install up and running with the tools necessary to work with this repo.

1. Install Xcode Command Line tools:

    ```
    xcode-select --install
    ```

2. Install Homebrew:

    ```
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ```

3. Update Homebrew and check if all is well:

    ```
    brew update
    brew update
    brew doctor
    ```

4. Install Homebrew cask:

    ```
    brew tap caskroom/cask
    ```

5. Install Terraform (>= v0.11.13):

    ```
    brew install terraform
    ```

6. Install VirtualBox (>= 6.0.4,128413):

    ```
    brew cask install virtualbox
    brew cask install virtualbox-extension-pack
    ```

7. Install Vagrant (>= 2.2.4):

    ```
    brew cask install vagrant
    vagrant plugin install vagrant-vbguest
    ```
