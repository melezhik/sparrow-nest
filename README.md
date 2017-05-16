# SYNOPSIS

Sparrow::Nest - custom Sparrow repository manager.

# Description

This is a simple specification and implementation of Sparrow custom repositories.

* Custom plugins should be hosted as remote Git repositories ( like  [private sparrow plugins](https://github.com/melezhik/sparrow#private-plugins)  )
* Custom repository is _just a list_ of `plg-name git-repository` pairs 
* `nested` - sparrow repository daemon exposes API to: 1) list plugins presented at repository (get index) 2) add/remove plugins from the list 
* [Sparrow client](https://github.com/melezhik/sparrow#sparrow-client) requests a custom repository index so that
custom sparrow plugins might be accessible at a target machine ( see `sparrow client setup` section )

# Install

    $ cpanm Sparrow::Nest

# Usage

    $ nestd start # start nestd daemon
    $ nestd stop  # stop nestd daemon
  
## API 

### get repository listing (index)

*GET /*

    curl 127.0.0.1:4441

### add plugin to the list (index)

*POST /add -d plugin-name=plugin-name -d url=$git-remote-url*

    curl -d name=df-check -d url=https://github.com/melezhik/df-check.git  -L  127.0.0.1:4441/add

### remove plugin from the list (index)

*POST /delete -d plugin-name=$plugin-name*

    curl -d name=df-check -d url=https://github.com/melezhik/df-check.git  -L  127.0.0.1:4441/delete

### Sparrow client setup

On target machine, given a nestd accessible as 192.168.0.1:4441

    $ echo repo: 192.168.0.1:4441 >> ~/sparrow.yaml 

Then get custom repository by:

    $ sparrow index update 

# nestd daemon

`nestd` is daemon to start customer repository manager.

    nestd $action %options

## Action

* `start` - start daemon
* `stop` - stop daemon
* `restart` - restart daemon

## Options

* `--host` - sets host
* `--port` - sets port

Examples:

    nestd start
    nestd start --host 0.0.0.0 --port 4442
    nestd restart
    nestd stop

# See also

[Sparrow](https://github.com/melezhik/sparrow)

# Author

[Alexey Melezhik](mailto:melezhik@gmail.com)
