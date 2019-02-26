#!/bin/bash
# Author: xuthus
# Time: 2019.2.26
# Function: 该脚本用于Fedora上一键安装搜狗输入法，测试于 Fedora29-GNOME

if [ $(id -u) != "0" ]; then
    echo "请使用管理员权限执行脚本！"
    exit
fi

## 安装配置
Install(){
#解决输入法依赖
    dnf install -y qtwebkit libidn-devel
    #解压和配置包 version: 2.2.0.0108
    tar xvJf sogou.tar.xz
    cp -pr usr/ /
    cp -pr etc/ /
    #链接共享库
    cp /usr/lib/x86_64-linux-gnu/fcitx/fcitx-sogoupinyin.so /usr/lib64/fcitx
    ln -s /usr/lib/x86_64-linux-gnu/fcitx/fcitx-punc-ng.so /usr/lib64/fcitx-punc-ng.so
    ln -s /usr/lib64/libidn.so.12 /usr/lib64/libidn.so.11
    #启动
    sogou-qimpanel
}

## fcitx安装配置
Config(){
    #解决环境依赖性
    dnf install -y fcitx fcitx-pinyin fcitx-configtool gnome-tweak-tool
    #开机启动fcitx
    cp fcitx.desktop ~/.config/autostart
    #重启时生效 默认输入法修改
    echo '#!/bin/bash' > /etc/profile.d/fcitx.sh
    echo 'export GTK_IM_MODULE=fcitx' >> /etc/profile.d/fcitx.sh
    echo 'export QT_IM_MODULE=fcitx' >> /etc/profile.d/fcitx.sh
    echo 'export XMODIFIERS=@im=fcitx' >> /etc/profile.d/fcitx.sh
    #本地默认输入法
    echo 'export GTK_IM_MODULE=fcitx' >> ~/.bashrc
    echo 'export QT_IM_MODULE=fcitx' >> ~/.bashrc
    echo 'export XMODIFIERS=@im=fcitx' >> ~/.bashrc
    #系统默认输入法
    
    echo "请重启计算机以生效！"
}

if [ "$1" == "config" ];then
    Config
fi

if [ "$1" == "install" ];then
    Install
fi
