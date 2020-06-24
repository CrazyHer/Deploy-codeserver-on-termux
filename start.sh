##Created by @CrazyHer
echo "开始安装..."
cd ~ &&\
apt update &&\
apt install clang vim curl wget git -y &&\
echo "deb [trusted=yes arch=all] https://yadominjinta.github.io/files/ termux extras" >> $PREFIX/etc/apt/sources.list &&\
pkg in atilo-cn -y &&\
atilo pull ubuntu &&\
echo '请设置code-server的访问密码，回车确认：' &&\
read code_password &&\
cat \
"echo '继续进行安装...' &&\
cd ~ &&\
apt update && apt install wget curl vim clang gcc net-tools python -y &&\
curl -sL https://deb.nodesource.com/setup_12.x | bash - &&\
apt-get install -y nodejs &&\
npm install -g yarn &&\
curl -fOL https://github.com/cdr/code-server/releases/download/v3.4.1/code-server_3.4.1_arm64.deb &&\
dpkg -i code-server_3.4.1_arm64.deb &&\
rm -rf ~/.config/code-server
mkdir ~/.config/code-server
cat 'bind-addr: 127.0.0.1:2333' >> ~/.config/code-server/config.yaml &&\
cat 'auth: password' >>~/.config/code-server/config.yaml &&\
cat password: $code_password >>~/.config/code-server/config.yaml &&\
cat 'cert: false'>>~/.config/code-server/config.yaml &&\
apt install nginx -y &&\
rm /etc/nginx/sites-enabled/default &&\
cat '
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
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection upgrade;
        proxy_set_header Accept-Encoding gzip;
        }
}
'>> /etc/nginx/sites-available/code-server &&\
ln -s /etc/nginx/sites-available/code-server /etc/nginx/sites-enabled/ &&\
cat 'code-server&;nginx'>>~/startcode.sh &&\
chmod 777 ~/startcode.sh &&\
echo '全部安装完成！以后进入ubuntu输入./startcode.sh就可以启动code-server服务器啦！' &&\
rm -rf ~/continue.sh ||echo '继续安装失败！'
">> ~/.atilo/ubuntu/root/continue.sh &&\
chmod 777 ~/.atilo/ubuntu/root/continue.sh &&\
echo "已通过atilo成功安装Ubuntu子系统在termux内" &&\
echo "请输入atilo run ubuntu进入ubuntu后" &&\
echo "继续输入命令: ./continue.sh 继续进行安装code-server" ||\
echo "安装失败！"
