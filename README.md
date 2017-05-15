# SYNOPSIS

Sparrow::Nest - custom Sparrow repositories manager.

# Install

    $ cpanm Sparrow::Nest

# Usage

    $ nestd start # start nestd daemon

API:

* get repository listing

    curl 127.0.0.1:4441

* add plugin to the list

    curl -d plugin-name=df-check -d url=https://github.com/melezhik/df-check.git 127.0.0.1:4441

* remove plugin to the list

    curl -X DELETE -d plugin-name=df-check 127.0.0.1:4441

Sparrow client setup:

On target machine, given a nestd accessible as 192.168.0.1:4441

    $ echo repo: 192.168.0.1:4441 >> ~/sparrow.yaml 

# See also

[Sparrow](https://github.com/melezhik/sparrow)

# Author

[Alexey Melezhik](mailto:melezhik@gmail.com)
