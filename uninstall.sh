#!/bin/bash
# Author: xuthus
# Time: 2019.2.26
# Function: 该脚本用于Fedora上一键卸载搜狗输入法，测试于 Fedora29-GNOME

if [ $(id -u) != "0" ]; then
    echo "请使用管理员权限执行脚本！"
    exit
fi

#移除无用依赖包
dnf remove -y qtwebkit libidn-devel

## 删除安装配置

rm -f /etc/X11/Xsession.d/72sogoupinyin
rm -f /etc/xdg/autostart/fcitx-ui-sogou-qimpanel.desktop
rm -f /usr/bin/sogou*
rm -f /usr/lib/mime/packages/fcitx-ui-sogou-qimpanel
rm -f /usr/lib/x86_64-linux-gnu
rm -f /usr/share/applications/fcitx-ui-sogou-qimpanel.desktop
rm -rf /usr/share/doc/sogoupinyin
