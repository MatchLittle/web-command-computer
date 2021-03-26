::网络检测
::开始会自动检测网络状态，若是网络畅通，读取字符进行匹配，若是不畅通锁屏，监测网络
::若是网络畅通，查看获取到的值和预设值是否匹配，若是匹配，执行匹配到的命令
@echo off
::设置编码格式
chcp 655530 
::设置需要执行的命令内容（放到本地化的命令内容）
set flag=""
::设置初始标识值(用来判断执行的命令是否是初次)
set orderCon=nan
::-----------------------------------------------------------------------------------------------------
::初始化的网络检测部分，-n 后的数值必须是大于0的整数，数值越小命令执行的速度越快
:check
ping -n 3 www.baidu.com
IF ERRORLEVEL 1 goto check
IF ERRORLEVEL 0 goto startConnect
::这里进行远程信息获取
:startConnect 
::获取网页里面命令的方法
curl http://192.168.1.201:8099/order/sys/order/getOrder > code.txt

set /p flag=<code.txt
::echo %flag%
::匹配命令是初次执行还是已经执行过
if %orderCon%==%flag% goto check
::监测是否有值，有的话执行命令，没有的话继续获取（这里设置为没有获取到默认是网络不好的问题，并不是文件丢失的问题）
IF ERRORLEVEL 1 goto check
IF ERRORLEVEL 0 goto orderExec
::命令执行部分
:orderExec
::-----------------------------------------------------------------------------------------------------
::执行一次之后，设置orderCon的值是当前执行的命令，证明已经执行过，再次查询命令的话，先判断这个命令是否被执行
set orderCon=%flag%
::锁屏
if %flag%==NanA1 rundll32.exe user32.dll LockWorkStation & goto check
::开启远程
if %flag%==NanB1 reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f & goto check
::关闭远程
if %flag%==NanB2 reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f & goto check
::强制关机
if %flag%==NanC1 shutdown -p -f  & goto check
::强制重启
if %flag%==NanD1 shutdown -r  & goto check
::睡眠电脑
if %flag%==NanD2 shutdown -h  & goto check
::激活远程桌面守护进程
::配置方法请参考博文 https://www.cnblogs.com/nanstar/p/13301860.html
::利用vbs实现无窗口启动cmd脚本命令
::CreateObject("WScript.Shell").Run "D:\autoLogin.bat",0,FALSE 
if %flag%==NanE1  D:\remoteDesk.vbs  & goto check
::发送系统状态的邮件到自己邮箱
::配置方法请参考博文 https://www.cnblogs.com/nanstar/p/13198531.html
if %flag%==NanF1  D:\senMail.vbs  & goto check

::设置系统命令部分
::-----------------------------------------------------------------------------------------------------
::打开一体化terminal
if %flag%==cmd start C:\Users\Administrator\AppData\Local\Microsoft\WindowsApps\wt.exe & goto check
::打开记事本
if %flag%==notepad start notepad.exe & goto check
::打开计算器
if %flag%==calc start calc.exe & goto check
::打开桌面
if %flag%==desk start desk.cpl & goto check
::打开系统属性
if %flag%==sysdm start sysdm.cpl & goto check
::打开控制面板
if %flag%==control start control.exe & goto check
::打开程序设置
if %flag%==appwiz start appwiz.cpl & goto check
::事件查看器
if %flag%==eventvwr start eventvwr.msc & goto check
::任务计划程序
if %flag%==taskschd start taskschd.msc & goto check
::系统信息
if %flag%==msinfo32 start msinfo32.exe & goto check
::防火墙高级安全
if %flag%==wf start wf.msc & goto check
::防火墙设置
if %flag%==firewall start firewall.cpl & goto check
::本地安全策略
if %flag%==secpol start secpol.msc & goto check
::计算机管理
if %flag%==compmgmt start compmgmt.msc & goto check
::资源监视器
if %flag%==perfmon start perfmon.exe & goto check
::网络属性（intnet ie浏览器的那个）
if %flag%==intcpl start intcpl.cpl & goto check
::电源选项
if %flag%==powercfg start powercfg.cpl & goto check
::鼠标配置
if %flag%==main start main.cpl & goto check
::网络连接，这个才是wifi网线连接显示的部分
if %flag%==ncpa start ncpa.cpl & goto check
::进入锁屏
if %flag%==die start notepad & goto die
::当发来的指令和所有命令不匹配的时候，此脚本可以执行任何命令
%flag% & goto check
::-----------------------------------------------------------------------------------------------------
::pause>nul
::进入锁屏
:die
rundll32.exe user32.dll LockWorkStation & goto check















