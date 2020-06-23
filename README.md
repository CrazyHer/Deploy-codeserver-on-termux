# Deploy-codeserver-on-termux
一个在termux上安装ubuntu并部署nginx+code-server的全自动脚本
安装完成后在termux中使用atilo run ubuntu进入ubuntu，运行~/startcode.sh就可以开启服务器，然后在局域网内访问 http://手机的IP地址:8080 就可以进入vscode了

在termux中输入以下命令开始安装
```shellscript
curl -fsSL https://github.com/CrazyHer/Deploy-codeserver-on-termux/releases/download/0.1/start.sh | sh
```
