### docker-git-alpine

Git client container built from source (currently 2.15.0) running on Alpine.

Forked from https://github.com/alpine-docker/git.
Main difference with the original project: git is compiled from source, so that we can have the very last version.

[![DockerHub Badge](https://dockeri.co/image/thirteenio/git-client)](https://hub.docker.com/r/thirteenio/git-client/)

### usage

    docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git thirteenio/git-client <git_command>

For example, if you need clone this repository, you can run

    docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git thirteenio/git-client clone https://github.com/thirteenio/git-client.git
    
### Optional usage 1:

To save your type, add this fuction to `~/.bashrc` or `~/.profile`
    
    $ cat ~/.profile
    
    ...
    
    function git () {
        (docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git thirteenio/git-client $@)
    }
    
    ...
    
    $ source ~/.profile

for example, if you need clone this repository, with the function you just set, you can run it as local command

    git clone https://github.com/thirteenio/git-client.git

### Optional usage 2:

    alias git="docker run -ti --rm -v $(pwd):/git -v $HOME/.ssh:/root/.ssh thirteenio/git-client"
    
#### NOTES:

- You need redefine (re-run) the alias, when you switch between different repositories
- You need run above alias command only under git repository's root directly.

## Demo

    $ cd application
    $ alias git="docker run -ti --rm -v $(pwd):/git -v $HOME/.ssh:/root/.ssh thirteenio/git-client"
    $ git clone git@github.com:YOUR_ACCOUNT/YOUR_REPO.git
    $ cd YOUR_REPO
    $ alias git="docker run -ti --rm -v $(pwd):/git -v $HOME/.ssh:/root/.ssh thirteenio/git-client"
    # edit several files
    $ git add . 
    $ git status
    $ git commit -m "test"
    $ git push -u origin master
    
### The Protocols

Supports git, http/https and ssh protocols.

Refer:
[Git on the Server - The Protocols](https://git-scm.com/book/en/v2/Git-on-the-Server-The-Protocols)

### TODO

* Optimise binary size (make them smaller)
* More builds for previous versions of git
* Fix "git diff" output which doesn't take colors into account
