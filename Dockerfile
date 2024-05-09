FROM ubuntu:22.04

ARG username=robin

RUN apt update && apt install -y sudo curl git unzip

# TODO: Install npm, cargo

RUN adduser --disabled-password --gecos '' ${username}
RUN adduser ${username} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN usermod -aG video ${username}
USER ${username}

# Install npm & gcc
RUN sudo apt install -y nodejs build-essential 

# Install Python3
RUN sudo apt install -y python3 python3-venv python3-pip

# Install go
WORKDIR ~
RUN curl -LO https://go.dev/dl/go1.22.3.linux-amd64.tar.gz
RUN sudo tar -C /usr/local -xzf go1.22.3.linux-amd64.tar.gz
RUN echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc

# Install neovim 0.9.5
WORKDIR /nvim-app
RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz
RUN tar xzvf nvim-linux64.tar.gz && rm nvim-linux64.tar.gz
RUN sudo ln -s /nvim-app/nvim-linux64/bin/nvim /usr/local/bin

# Install neovim config
RUN mkdir ~/.config
RUN git clone https://github.com/RobinHeitz/nvim-conf.git
RUN sudo ln -s /nvim-app/nvim-conf ~/.config/nvim

# Installing tmux
RUN sudo apt install -y tmux
RUN git clone https://github.com/RobinHeitz/tmux-conf.git
RUN sudo ln -s /nvim-app/tmux-conf ~/.config/tmux
