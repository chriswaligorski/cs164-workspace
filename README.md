# CS164 Workspace

## Introduction

Welcome to the CS164 Workspace, a Docker-based environment for CS 164! This image is designed to provide a standardized development environment for students regardless of host architecture or OS, without the hassle of VPN'ing into an instructional machine.

## Prerequisites
Docker is a cross-platform tool for managing containers. You can use Docker to download and run the Workspace we have prepared for this course.

First, you will have to download and install Docker to your machine so you can access the Workspace. This can be done in one of following two ways.

- **(Preferred)** Download the Docker Desktop app from the [Docker website](https://docs.docker.com/desktop/).
- **(or)** download both the [Docker Engine](https://docs.docker.com/engine/) and [Docker Compose](https://docs.docker.com/compose/)

## Getting Started
Lucky for you, we have already built the image for both ARM and x86 machines (hosted on [Docker Hub](TODO)

After Docker has been installed, type the following into your terminal to initalize the Docker Workspace and begin an SSH session. These commands will download our Docker Workspace from our server and launch it. The download of the Workspace will take some time and requires an Internet connection.

_Note: Docker commands will generally have to be run with sudo access, so for the commands below you might need to use `sudo docker-compose up -d`._

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

_Note: Changing the host port (on the right of the :) will require you to add the new port to /etc/ssh/sshd_config

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
   If you do not already have an SSH public key, follow the instructions [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key) 
   
   ```bash
   ssh-copy-id -p 16444 -i ~/.ssh/id_ed25519.pub workspace@127.0.0.1
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

Happy coding!

