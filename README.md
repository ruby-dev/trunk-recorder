# TRUNK RECORDER APP

#### HOW TO INSTALL?

1. Clone the repository `git clone https://github.com/ruby-dev/trunk-recorder.git`
2. Change to the working directory `cd trunk-recorder`
3. Create your .env file `cp .env.example .env`
4. Create the stack `docker-compose up -d`
5. Create your network

   Nginx Proxy Manager: `network.tld.com`

   Radio Scanner: `radio.tld.com` => `http://radio:3000`

   Icecast Container: `stream.tld.com` => `http://icecast:8000`

<br />
