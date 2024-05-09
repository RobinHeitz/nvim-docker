# Testing with a portable nvim setup within docker container

The idea is to bind the project directory into the container with already working setup.

## Setup container

Not everything can be setup and installed by the docker build process. Therefore, the idea is to start the container
and complete setup. Afterwards we commit this container.

### Manual installation steps

```
# Cargo install
curl https://sh.rustup.rs -sSf | sh


# fzf install
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

### Deployement

Build:

```
docker build -t nvim-ubuntu . --platform linux/amd64
```

Commit:

```
docker commit 
```
