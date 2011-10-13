# Linux Flash Develp
LFD will help you build and debug flash(ActionScript3 and Flex) project on Linux.  
LFD 可以帮助你在Linux下开发和调试Flash(ActionScript3和Flex)项目

## 使用方法

    lfd -T      #显示所有任务
    lfd init    #在当前目录初始化项目
    lfd build   #编译项目
    lfd run     #以flashplayer打开编译出来的flash文件
    lfd test    #编译并打开
    lfd destroy #删除项目

## 配置
在$HOME/.bashrc中指定以下配置：

    export MXMLC="/path/to/flex_sdk/bin/mxmlc"
    export FLASH_PLAYER="/path/to/flashplayer_standalone"

## 本项目的状态
业余时间开发，因此功能比较简陋，会逐渐补全功能。
