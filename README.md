# Kong request-decrypt

A Kong plugin, that let you decrypt json request.

#   Inspired by Kong official plugin

    https://github.com/Kong/kong/tree/master/kong/plugins/request-transformer


## Installation

    $ luarocks install request-decrypt

To make Kong aware that it has to look for the new plugin, you'll have to add it to the custom_plugins
property in your configuration file.

```yaml
custom_plugins:
    - request-decrypt
```

Remember to restart Kong.    


## Configuration

You can add the plugin with the following request:

```bash
$ curl -X POST http://kong:8001/apis/{api}/plugins \
    --data "name=request-decrypt" \
    --data "config.encryption_key=my-secret-key"
```

