#!/bin/bash
##Created by @CrazyHer
echo '继续进行安装...' &&\
cd ~ &&\
apt update && apt install wget curl dialog clang gcc g++ net-tools python -y &&\
curl -sL https://deb.nodesource.com/setup_12.x | bash - &&\
apt-get install -y nodejs &&\
npm install -g yarn &&\
curl -fOL https://github.com/cdr/code-server/releases/download/v3.4.1/code-server_3.4.1_arm64.deb &&\
dpkg -i code-server_3.4.1_arm64.deb ||(echo '继续安装失败！你可以输入./continue.sh重新继续安装' && exit 0)
rm -rf ~/.config/code-server
mkdir ~/.config/code-server
echo '请设置code-server的访问密码，回车确认：' 
read code_password 
echo "设置成功，你的访问密码是 $code_password " &&\
echo 'bind-addr: 127.0.0.1:2333' >> ~/.config/code-server/config.yaml &&\
echo 'auth: password' >>~/.config/code-server/config.yaml &&\
echo "password: $code_password" >>~/.config/code-server/config.yaml &&\
echo 'cert: false'>>~/.config/code-server/config.yaml &&\
apt install nginx -y &&\
rm /etc/nginx/sites-enabled/default &&\
echo '
server {
       ##外网访问端口
       listen 8080;
       ##服务器域名，在没有域名、只在局域网内访问的情况下，就填_就行了
       server_name _;

       ##地址，如果需要重定向请自己配置，这里直接以根目录开始
       location / {
        ##本地code-server的端口
        proxy_pass http://localhost:2333/;
        ##必要的头设置
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection upgrade;
        proxy_set_header Accept-Encoding gzip;
        }
}'>> /etc/nginx/sites-available/code-server &&\
ln -s /etc/nginx/sites-available/code-server /etc/nginx/sites-enabled/ &&\
echo 'code-server &;nginx'>>~/startcode.sh &&\
chmod 777 ~/startcode.sh &&\
echo '全部安装完成！以后进入ubuntu输入./startcode.sh就可以启动code-server服务器啦！' ||echo '继续安装失败！'
rm -f ~/continue.sh ~/.bashrc
mv ~/.bashrcbak ~/.bashrc
