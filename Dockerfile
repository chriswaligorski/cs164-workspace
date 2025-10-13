# Use the amd64 platform explicitly
FROM --platform=linux/amd64 ubuntu

# Set home
ENV HOME=/home/workspace

# Install necessary packages
RUN apt update && apt install -y \
    git \
    vim \
    nasm \
    sudo \
    openssh-server \
    gcc \
    opam

RUN useradd --create-home --home-dir /home/workspace --user-group workspace && echo workspace:workspace | chpasswd \
  && chsh -s /bin/bash workspace && echo "workspace ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Copy over home directory
WORKDIR /home/workspace
COPY ./home/. ./

# Copy over entrypoint,sh
WORKDIR /
COPY entrypoint.sh .

RUN chown -R workspace:workspace /home/workspace

# IMPORTANT: disable PAM to prevent ssh issues over rosetta
RUN sed -i 's/UsePAM yes/UsePAM no/' etc/ssh/sshd_config

# Change default ssh listening port to 44
RUN sed -i 's/#Port 22/Port 44/' /etc/ssh/sshd_config

RUN mv /home/workspace /workspace

USER workspace

ENTRYPOINT [ "/entrypoint.sh" ]

