# Linux Flash Develp
LFD 可以帮助你在Linux下开发和调试Flash(ActionScript3和Flex)项目

## 解决的问题
1. 在Linux下没有方便的flash编译工具，手动写命令比较繁琐
2. 新的播放器默认不会将trace输出到终端，查看程序日志比较麻烦

## 使用方法

    lfd         #显示帮助
    lfd init    #在当前目录初始化项目
    lfd build   #编译项目
    lfd run     #以flashplayer打开编译出来的swf文件
    lfd test    #编译并打开,  等同于 lfd build && lfd run
    lfd clean   #删除项目，会删除lfd创建出来的 asproj.info 文件

##  安装
###  系统要求
1. ruby 1.9.2+ 运行环境

    unbuntu 下可以通过命令安装

        sudo apt-get install ruby1.9.1

2. flex sdk

    可以从Adobe官方网站[下载](http://opensource.adobe.com/wiki/display/flexsdk/Flex+SDK)，建议使用4.5以上的SDK

3. 独立Flash播放器

    可以从Adobe官方网站[下载](http://www.adobe.com/support/flashplayer/downloads.html)，建议使用最新的Debugger版

### 安装LFD

    gem install lfd

## 配置

lfd 运行时会调用flex sdk和flash播放器，请将他们所在的路径添加到$PATH中.
在$HOME/.bashrc中指定以下配置：

    export MXMLC="/path/to/flex_sdk/bin/mxmlc"
    export FLASH_PLAYER="/path/to/flashplayer_standalone"
