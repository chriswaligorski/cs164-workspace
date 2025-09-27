# Force x86-64 architecture
FROM --platform=linux/amd64 ubuntu

# Install packages
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
  --mount=target=/var/cache/apt,type=cache,sharing=locked \
  rm -f /etc/apt/apt.conf.d/docker-clean \
  &&  apt update \
  && apt install -y \
  clang \
  curl \
  gcc \
  vim \
  git \
  wget \
  sudo \
  zip \
  unzip \
  opam \
  ocaml \
  ocaml-native-compilers \
  ocaml-findlib \
  && apt clean \
  && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --home-dir /home/workspace --user-group workspace \
  && echo workspace:workspace | chpasswd \
  && chsh -s /bin/bash workspace \
  && echo "workspace ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /home/workspace
COPY ./home/. ./

RUN git config --global init.defaultBranch main

COPY ./install_scripts/. /install_scripts
WORKDIR /install_scripts
RUN ./setup-ocaml.sh # TODO write this setup script

WORKDIR /
COPY entrypoint.sh .
COPY ./bin/. ./bin

RUN find /home/workspace/. -not -type d -not -path "./code/*" -not -name ".version" -print0 \
  | LC_ALL=C sort -z \
  | xargs -0 sha256sum \
  | sha256sum > /home/workspace/.version

RUN chown -R workspace:workspace /home/workspace

RUN mv /home/workspace /workspace

USER workspace

ENTRYPOINT [ "/entrypoint.sh" ]

  


