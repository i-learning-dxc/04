
## 環境差異について
本レポジトリはDXC04の受講を手助けするためのコマンド一覧となります。

授業進行の中で、"dxc04.work"というDNSサービスを使用していますが、講義期間外は利用ができません。
コマンド及びファイル中の"dxc04.work"は"nip.io"という公開DNSサービスに置き換えてご使用ください。

## 準備

演習環境では実施済みのため不要の手順です。
ご自身の環境で演習する場合は参考にしてください。

演習環境
|||
|:--|:--|
|OS|Ubuntu 22.04LTS|
|Instance| AWS EC2 t2.xlarge|
|CPU|4vCPU|
|MEM|16GB|
|HDD|16GB|

### Docker Install

```
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo apt-get -y install docker-compose
sudo usermod -a -G docker ubuntu
newgrp docker
```

## 準備

```
$ cd
$ git clone https://github.com/i-learning-dxc/04.git i-learning-DXC04
```


# 2.2.1.

```
$ sudo docker run --detach \
--hostname gitlab.{your Instance IP}.dxc04.work \
--publish 443:443 --publish 80:80 \
--name gitlab \
--restart always \
--volume /home/ubuntu/gitlab/config:/etc/gitlab \
--volume /home/ubuntu/gitlab/logs:/var/log/gitlab \
--volume /home/ubuntu/gitlab/data:/var/opt/gitlab \
gitlab/gitlab-ee:latest

```

# 2.2.2.

```
$ docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
$ docker rm -f gitlab
$ docker ps
```

# 2.2.4.

```
$ cd i-learning-DXC04/DXC04/2.2.3/gitlab-compose
$ vi docker-compose.yml
$ docker-compose up -d
$ docker-compose ps
```

# 2.2.4.1.

```
$ docker exec -it gitlab-compose_gitLab_1 grep 'Password:' /etc/gitlab/initial_root_password
```

# 2.3.2.4.

```
$ ssh-keygen -t rsa
```

# 2.3.2.6.

```
$ cat /home/ubuntu/.ssh/id_rsa.pub
```

# 2.3.2.8.

```
$ vi ~/.ssh/config
```

```
Host gitlab.{your Instance IP}.dxc04.work
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa
    Port 9922
    User git
```

```
$ chmod 600 ~/.ssh/config
```

# 2.3.2.9.

```
$ cd 
$ git clone git@gitlab.{your Instance IP}.dxc04.work:root/dxc04.git
```

# 2.3.4.1.

```
$ curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
$ sudo apt-get install gitlab-runner
```

# 2.3.4.3.

```
$ sudo usermod -aG docker gitlab-runner
```

```
$ sudo -u gitlab-runner -H docker info
```

# 2.3.5.1.

```
$ sudo gitlab-runner register -n \
  --url https://gitlab.{your Instance IP}.dxc04.work \
  --token {REGISTRATION_TOKEN} \
  --executor shell  --executor docker \
  --docker-image "docker:latest"
```

# 2.3.5.3.

```
$ sudo vi /etc/gitlab-runner/config.toml
$ sudo useradd docker -g docker
$ sudo gitlab-runner restart
```

# 2.3.7.1.

```
$ git config --global user.email "メールアドレス" 
$ git config --global user.name "⽒名"
$ cd ~/dxc04
$ cp ~/i-learning-DXC04/DXC04/2.3.7/* ./
$ git add . 
$ git status
$ git commit -m "wip"
$ git push -u origin main
```

# 3.2.3

```
$ cd ~/i-learning-DXC04/DXC04/3.2.3/
$ docker build . -t dxc04-3.2.3
$ docker run --name dxc04-3.2.3 -d -p 8081:80 dxc04-3.2.3:latest
```

# 3.3.1

```
$ cd ~/
$ git clone https://github.com/docker/docker-bench-security.git 
$ cd docker-bench-security/
$ sudo sh docker-bench-security.sh 
```

# 3.3.2

```
$ sudo sh docker-bench-security.sh -c check_1_1_3 -p
$ sudo apt –y install auditd
$ sudo sh -c "echo '-w /usr/bin/dockerd -k docker' >> /etc/audit/rules.d/audit.rules" 
$ sudo systemctl restart auditd
$ sudo sh docker-bench-security.sh -c check_1_1_3 -p
```

# 3.3.3.1.

```
$ sudo sh -c "echo '-w /usr/bin/runc -k docker' >> /etc/audit/rules.d/audit.rules" 
$ sudo systemctl restart auditd
$ sudo sh docker-bench-security.sh -c check_1_1_18 -p
```

# 3.3.3.5

```
$ sudo sh -c "echo '-w /run/containerd -k docker' >> /etc/audit/rules.d/audit.rules"
$ sudo systemctl restart auditd
$ sudo sh docker-bench-security.sh -c check_1_1_4 -p
```

```
$ sudo sh -c "echo '-w /var/lib/docker -k docker' >> /etc/audit/rules.d/audit.rules"
$ sudo systemctl restart auditd
$ sudo sh docker-bench-security.sh -c check_1_1_5 -p
```

```
$ sudo sh -c "echo '-w /etc/docker -k docker' >> /etc/audit/rules.d/audit.rules"
$ sudo systemctl restart auditd
$ sudo sh docker-bench-security.sh -c check_1_1_6 -p
```

# 3.3.6

```
$ cd ~/i-learning-DXC04/DXC04/3.2.3/
$ docker stop dxc04-3.2.3
$ docker rm dxc04-3.2.3
$ docker build . -t dxc04-3.2.3
$ docker run --name dxc04-3.2.3 -d -p 8081:80 dxc04-3.2.3:latest
```

# 5.1.4.1

```
$ cd ~/i-learning-DXC04/DXC04/5.1.4/drupal
$ docker run --rm drupal:9.5.0-php8.1-apache-bullseye bash -c "composer require drush/drush && \
tar -cC /opt/drupal --exclude ./vendor --exclude ./web/core --exclude ./web/profiles ." \
| tar -xC ./
```


# 5.1.5

```
$ docker container run --name mariadb -e MARIADB_ROOT_PASSWORD=password -d mariadb
$ docker ps
$ docker stop mariadb
```

# 5.1.9.

```
$ cd ~/i-learning-DXC04/DXC04/5.1.4/drupal
$ docker run --rm drupal:9.5.0-php8.1-apache-bullseye bash -c "composer require drush/drush && \
tar -cC /opt/drupal --exclude ./vendor --exclude ./web/core --exclude ./web/profiles ." \
| tar -xC ./
$ chmod 755 docker-entrypoint.sh
$ docker-compose build
$ docker-compose up -d
```
