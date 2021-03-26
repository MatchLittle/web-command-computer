# web-command-computer

------

#### Author: Nan

#### PushDate: 2020/07/29

#### Introduction: Use the web to send instructions to your computer, and the computer will execute it automatically

#### 使用页面发送命令到电脑，电脑会自动的执行接收到的命令

---------

#### Directory

------

*SpringBoot+Redis+Cmd+Vue*

------

> #### auto
>
> 自动部署，能一键把运行环境在本地配置好，不过需要你以管理员权限运行这个脚本，不过你放心，源码你是可以看到的

> #### boot
>
> 放开机引导文件的目录，用来放开机启动脚本和命令获取检测脚本
>
> *autoLogin.vbs* 
>
> 用来无窗口执行命令获取脚本，需要将这个脚本放到以下目录里
>
> C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
>
> *computerOrderCheck.bat* 
>
> 自动获取服务端命令，并根据远程获取到的命令内容，在本地匹配命令并无条件执行，拥有断网重连自动恢复命令获取连接的作用（脚本内的预设命令可以进行修改）

> #### order
>
> 后端代码
>
> 本地访问的接口部分，主要负责存储命令和返回当前命令

> #### webpage
>
> 前端代码
>
> 包含访问的前端页面，以及页面引用的一些文件和图片





