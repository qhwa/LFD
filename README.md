# Linux Flash Develp
LFD,  which stands for "Linux Flash Develop", will help you develop Flash and Flex applications on Linux, especially Ubuntu.

## Pain of Flash Developing On Linux
1. you must write many lines of command to compile your code into a swf file
2. 'trace' do not output in standard output (such as terminal) in new version of standalone flash player

LFD is your firend if you are suffering from the pain as well as me.

## Usage

    lfd init    # init your project home, creating file: asproj.info, making dirs: bin/ src/ lib/ etc.
    lfd build   # compile your appliation (configed in asproj.info) with a binary swf file output
    lfd run     # open swf file with standalone Adobe flash player.
    lfd test    # equals "lfd build && lfd run"
    lfd clean   # delete project info file and folders created by LFD. will not delete non-empty folder

##  Installation
###  System Requirements
1. ruby 1.9.2+ 

    you can install ruby1.9.2 with this commands on unbuntu:

        sudo apt-get install ruby1.9.1

2. Flex SDK

    you can [download](http://sourceforge.net/adobe/flexsdk/wiki/Downloads/) Flex SDK from Adobe, version 4.5+ is suggested because I havn't test many versions of SDK.

3. Standalone Flash Player

    you can [download](http://www.adobe.com/support/flashplayer/downloads.html) it from Adobe. Make sure to use the latest debugger version.

### Install LFD

    gem install lfd

## Configuration

LFD depends on Flex SDK and Flash Player heavily. Please config them in your bash config (~/.bashrc commonly)

    export MXMLC="/path/to/flex_sdk/bin/mxmlc"
    export FLASH_PLAYER="/path/to/flashplayer_standalone"
