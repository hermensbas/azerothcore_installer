# Install or Update

Haven't tested the update, personally i did a new install. So test when in doubt.

1. Backup DB or use export characters through the AC (dump) command options.

2. Go to https://dev.mysql.com/downloads/repo/apt/ for the latest apt package

3.
```bash
wget https://dev.mysql.com/get/mysql-apt-config_0.8.32-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.32-1_all.deb

sudo apt update
sudo apt install mysql-server
````

Make sure your select 8.4.2 in the configuration screen ;)
