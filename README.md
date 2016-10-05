docker-flexget
==============

Docker image for Flexget client.

[![](https://images.microbadger.com/badges/image/phlak/flexget.svg)](http://microbadger.com/#/images/phlak/flexget "Get your own image badge on microbadger.com")


Running the Container
---------------------

Place your Flexget [configuration file](http://flexget.com/wiki/Configuration) in a directory on
your host file system (i.e. `/srv/flexget`) with the name `config.yml`. Then run the Flexget client:

    docker run -d -v /srv/flexget:/etc/flexget --name flexget-client phlak/flexget


#### Optional 'docker run' Arguments

`--restart always` - Always restart the container regardless of the exit status. See the Docker
                     [restart policies](https://goo.gl/OI87rA) for additional details.

Troubleshooting
---------------

Please report bugs to the [GitHub Issue Tracker](https://github.com/PHLAK/docker-flexget/issues).

Copyright
---------

This project is liscensed under the [MIT License](https://github.com/PHLAK/docker-flexget/blob/master/LICENSE).
