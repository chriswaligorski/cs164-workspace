# CS164 Workspace

```bash
                  ,,__
        ..  ..   / o._)                   .---.
       /--'/--\  \-'||        .----.    .'     '.
      /        \_/ / |      .'      '..'         '-.
    .'\  \__\  __.'.'     .'          i-._
      )\ |  )\ |      _.'
     // \\ // \\
    ||_  \\|_  \\_
mrf '--' '--'' '--'
```
_ASCII Art by Morfina_

## Introduction

Welcome to the CS164 Workspace! CS164 assignments require compiling to and executing x86-64 assembly, which cannot be done natively on Apple silicon's ARM64. This workspace allows you to emulate x86-64 in a Docker container with the power of Rosetta, letting you complete assignments 100% locally on your Apple Silicon Mac!

## Prerequisites
Docker is a cross-platform tool for managing containers. You can use Docker to download and run the Workspace we have prepared for this course.

First, you will have to download and install Docker to your machine so you can access the Workspace. This can be done in one of following two ways.

- **(Preferred)** Download the Docker Desktop app from the [Docker website](https://docs.docker.com/desktop/).
- **(or)** download both the [Docker Engine](https://docs.docker.com/engine/) and [Docker Compose](https://docs.docker.com/compose/)

For the best performance, open Docker Desktop and go to Settings -> General -> Virtual Machine Options and select "Apple Virtualization Framework", "Use Rosetta for x86_64/amd64 emulation on Apple Silicon", and "VirtioFS".

## Getting Started
The cs164-workspace image is already hosted for you on [Docker Hub](https://hub.docker.com/r/chriswaligorski/cs164-workspace).

After Docker has been installed, type the following into your terminal to initalize the Docker Workspace and begin an SSH session. These commands will download the image from the hub and launch it. This will take some time and require an internet connection.

_Note: Docker commands sometimes have to be run with sudo access, so for the commands below you might need to use `sudo docker-compose up -d`._

1. **Clone this GitHub Repository**
   ```bash
   git clone https://github.com/chriswaligorski/cs164-workspace.git
   ```

2. **Navigate to the Repository**
   ```bash
   cd cs164-workspace
   ```

3. **Run Docker Compose for the first time**
   ```bash
   docker-compose up
   ```

   This command will build and start the Docker container defined in the `docker-compose.yml` file. If needed, you can change the port used for SSH within this file.

   _Note: Changing the host port (on the right side of the colon) will require you to add the new port to /etc/ssh/sshd\_config._

   Wait until you see "Docker workspace is ready!" in the terminal. As you might have guessed, the Workspace is now ready.
   
   Use <kbd>Ctrl</kbd> + <kbd>C</kbd> to stop the command.

4. **Starting the container in the background**
   ```bash
   docker-compose up -d
   ```
   This will simply start the container in the background and keep it running. With Docker Desktop, you can also manage this through the GUI.

5. **SSH into the Container**
   ```bash
   ssh workspace@localhost -p 16444
   ```

   Use the password `workspace` the first time you SSH into the container.
  
6. **Stop the container**
   
   _Within your host machine's shell (not the Workspace shell you ssh'd into)_:
   ```bash
   docker-compose down
   ```
   This will stop the container. Your data should still be saved within the hidden `.workspace` folder, so you can restart the container as needed and pick up where you left off.

   **Note: To be safe, always push work you want to keep to Github!**
   
   **Use with caution:** If you ever need it, you can use `sudo rm -rf .workspace` to reset the Workspace. 

## Avoiding Password Entry

To avoid entering the password every time you SSH into the container, follow these additional steps from your host machine:

1. **Copy Your SSH Key**
   If you do not already have a SSH public key, follow the instructions [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key) 
   
   ```bash
   ssh-copy-id -p 16444 -i ~/.ssh/id_ed25519.pub workspace@localhost
   ```

   If different from the default, replace `~/.ssh/id_ed25519.pub` with the path to your SSH public key.

2. **Update SSH Config**
   To alias the full SSH command, add the following lines to your `~/.ssh/config` file:
   ```
   Host docker164
     HostName 127.0.0.1
     Port 16444
     User workspace
     IdentityFile ~/.ssh/id_ed25519
   ```
You can now enjoy a passwordless SSH experience for your CS164 workspace:
`ssh docker164`

## Connect Your Workspace To GitHub

To pull from and push to your Github account from the workspace, you need to generate an SSH public key and add it to your GitHub profile.

1. **Generate SSH Key**
   Insert the email associated with your GitHub account in place of you@example.com and run the command to create a key pair. Choose a file location and a passphrase (or press enter to choose the default location and no passphrase).

   ```bash
   ssh-keygen -t ed25519 -C "you@example.com"
   ```

2. **Add SSH Key To Your GitHub Account**
   Go to [GitHub -> Settings -> Keys](https://github.com/settings/keys) and click "New SSH Key" in the top right. Choose a title for the new key, copy the output of the following command, and paste it in the "Key" box.

   ```bash
   cat /home/workspace/.ssh/id_ed25519.pub
   ```

_Note: If you chose a different file location in the first step, replace this default location with the one you chose.

3. **Verify You Can Connect**
   
   Run this command to verify that GitHub recognizes your ssh key. Enter 'yes' if prompted.

   ```bash
   ssh -T git@github.com
   ```

   If the output is: "Hi {username}! You've successfully authenticated, but GitHub does not provide shell access.", then you're good to go!

## Setting Up Your OCaml Environment

To set up opam and install the necessary packages for CS164 assignments:

1. **Initialize Opam**
   Run the following commands and enter 'y' when prompted
   ```bash
   opam init
   eval $(opam env --switch=default)
   ```

2. **Install Packages**
   Install the packages needed for CS164

   ```bash
   opam install dune utop ounit2 ppx_deriving ppx_inline_test ppx_let ppx_blob shexp core core_unix yojson menhir
   ```

   This list is probably not comprehensive. Install any additional packages using

   ```bash
   opam install <package name>
   ```

## Acknowledgments
This repository was adapted from CS162's [cs162-workspace](https://github.com/Berkeley-CS162/cs162-workspace), developed by Wilson Nguyen.

### _Happy compiling!_ ###

