##Created by @CrazyHer
echo "开始安装..."
cd ~ &&\
apt update &&\
apt install clang curl wget python -y &&\
echo "deb [trusted=yes arch=all] https://yadominjinta.github.io/files/ termux extras" >> $PREFIX/etc/apt/sources.list &&\
apt update &&\
apt install atilo-cn -y &&\
atilo pull ubuntu ||echo "安装失败或atilo ubuntu已安装，脚本仍将继续......"
echo "已通过atilo成功安装Ubuntu子系统在termux内" &&\
echo "部署后续脚本..." &&\
curl https://raw.githubusercontent.com/CrazyHer/Deploy-codeserver-on-termux/master/continue.sh >> ~/.atilo/ubuntu/root/continue.sh &&\
chmod 777 ~/.atilo/ubuntu/root/continue.sh &&\
cp ~/.atilo/ubuntu/root/.bashrc ~/.atilo/ubuntu/root/.bashrcbak &&\
echo '~/continue.sh'>> ~/.atilo/ubuntu/root/.bashrc &&\
echo "现在将通过atilo run ubuntu进入ubuntu子系统继续安装" &&\
atilo run ubuntu ||\
echo "安装失败！"