# Linux Flash Develp
LFD,  which stands for "Linux Flash Develop", will help you develop Flash and Flex applications on Linux, especially Ubuntu. 
Later version of LFD can also be run on Mac with Ruby installed. One may use LFD instead of Flash Builder for firendly command line usage.

## Pain of Flash Developing On Linux

1. official support has been dropped on Linux for a long time. AIR and Flash Builder are not available on Linux. 
1. you must write many lines of command to compile your code into a swf file
2. 'trace' do not output in standard output (such as terminal) in new version of standalone flash player

I don't want to switch from my workspace on Linux to Windows to do some little developing of flash. And I prefer command line tools and vim over Flash Builder.

So I wrote this little gem to make it easy to develop flash applications in Linux. LFD is your firend if you are suffering from the pain as well as me.

See it in action:

## Usage

    lfd env     # check the develop environment
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

    or use [rvm](http://rvm.io) to install ruby

2. Flex SDK

    you can [download](http://sourceforge.net/adobe/flexsdk/wiki/Downloads/) Flex SDK from Adobe, version 4.5+ is suggested because I havn't test many versions of SDK.

3. Standalone Flash Player

    you can [download](http://www.adobe.com/support/flashplayer/downloads.html) it from Adobe. Make sure to use the latest debugger version.

### Install LFD

    gem install lfd

## Configuration

LFD depends on Flex SDK and Flash Player heavily. Please config them in your bash config (~/.bashrc commonly) to make sure Flex SDK is executable in your shell. To check which flex sdk is choosen, just run `lfd env`. Here's what it outputs in my laptop:

![lfd-env-output](http://xiaotuhe.com/uploads/share/file/1e245635077b6ac91c430241603f5e78.png)

You may have multiples versions of Flex SDKs installed, and choose one for lfd, by setting the MXMLC/COMPC/FLASH_PLAYER variables, e.g:

    MXMLC="/path/to/flex_sdk/bin/mxmlc" \
    FLASH_PLAYER="/path/to/flashplayer_standalone" \
    lfd test


