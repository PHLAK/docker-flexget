docker-flexget
==============

<p align="center">
    <img src="docker-flexget.png" alt="Docker Flexget" width="800">
<p>

<p align="center">
  <a href="http://microbadger.com/#/images/phlak/flexget"><img src="https://images.microbadger.com/badges/image/phlak/flexget.svg" alt="Microbadger"></a>
  <a href="https://ln.phlak.net/join-slack"><img src="https://img.shields.io/badge/Join_our-Slack-611f69.svg" alt="Join our Slack"></a>
  <a href="https://github.com/users/PHLAK/sponsorship"><img src="https://img.shields.io/badge/Become_a-Sponsor-cc4195.svg" alt="Become a Sponsor"></a>
  <a href="https://patreon.com/PHLAK"><img src="https://img.shields.io/badge/Become_a-Patron-e7513b.svg" alt="Become a Patron"></a>
  <a href="https://paypal.me/ChrisKankiewicz"><img src="https://img.shields.io/badge/Make_a-Donation-006bb6.svg" alt="One-time Donation"></a>
  <a href="https://www.ChrisKankiewicz.com"><img src="https://img.shields.io/badge/Created_by-Chris%20Kankiewicz-319795.svg" alt="Author"></a>
</p>

<p align="center">
    Docker image for <a href="https://flexget.com">FlexGet</a> client.
</p>

---

Running the Container
---------------------

In order to persist configuration data through container upgrades you should create a named data
volume where your config data will be stored. This is not required but is _highly_ recommended.

    docker volume create --name flexget-data

Next you _must_ create your [config file](http://flexget.com/wiki/Configuration):

    docker run -it --rm -v flexget-data:/etc/flexget phlak/flexget vi /etc/flexget/config.yml

<details>
    <summary>Example config</summary>

    tasks:
    test task:
        rss: http://mysite.com/myfeed.rss
        series:
        - My Favorite Show
        - Another Good Show:
            quality: 720p
</details>

After the config file has been created run the client container with the named data volume:

    docker run -d -v flexget-data:/etc/flexget --name flexget-client phlak/flexget

#### Optional 'docker run' Arguments

`-e TZ=America/Phoenix` - Set the timezone for your server. You can find your timezone in this
                          [list of timezones](https://goo.gl/uy1J6q). Use the (case sensitive)
                          value from the `TZ` column. If left unset, timezone will be UTC.

`--restart unless-stopped` - Always restart the container regardless of the exit status, but do not
                             start it on daemon startup if the container has been put to a stopped
                             state before. See the Docker [restart policies](https://goo.gl/Y0dlDH)
                             for additional options.

Configuring FlexGet
-------------------

Once you have a running client container, you can edit the FlexGet config with:

    docker exec -it flexget-client vi /etc/flexget/config.yml

After saving changes, restart your container with `docker restart flexget-client`

Troubleshooting
---------------

For general help and support join our [Slack Workspace](https://ln.phlak.net/join-slack).

Please report bugs to the [GitHub Issue Tracker](https://github.com/PHLAK/docker-flexget/issues).

Copyright
---------

This project is licensed under the [MIT License](https://github.com/PHLAK/docker-flexget/blob/master/LICENSE).
