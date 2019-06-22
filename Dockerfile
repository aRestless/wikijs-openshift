FROM requarks/wiki:latest

RUN chgrp -R 0 /var/wiki && chmod -R g=u /var/wiki

WORKDIR /var/wiki

RUN ln -s /var/wiki/config/config.yml config.yml

ENTRYPOINT [ "node", "server" ]