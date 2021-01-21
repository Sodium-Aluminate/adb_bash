# adb_bash

 - 一个给 adb shell 染色的 magisk 模块
 
# 介绍

 - 只要用过 adb shell 的人都可能有这个疑问：为什么系统自带 shell 是 mksh？

 - 大概系统应用开发者挺喜欢 mksh 的（因为小巧？），但我用不惯。

 - 至少把 adb shell 给劳资换成 bash 啊！

# 安装

从 [releases](https://github.com/Sodium-Aluminate/adb_bash/releases) 下载或者把这个 repo 打包为 zip（都一样）。
在 magisk manager 里安装。

# 卸载

1. 在 magisk manager 里卸载（如果你连开机都做不到了，在 recovery 里执行 `rm -rf /data/adb/modules/adb_bash`）

2. 如果你有“清理垃圾文件”强迫症，删掉 `/data/adb_home`

3. ~~向作者抱怨模块不好用~~

# 工作原理

自带的 sh `/system/bin/sh` 是 mksh, 会自动读取 `/etc/mkshrc`.

(`/etc` 是 `/system/etc` 的软链接)

因此在 `/system/etc/mkshrc`里添加脚本即可。

(mkshrc 里面原来的脚本被保留。)

添加的脚本会检查 uid=2000 (adb) 且交互运行 running interactively，然后执行 bash 并用 --rcfile 参数指定进一步美化的 .bashrc

# su 之后没颜色了咋办？

magisk su 很魔法，执行 `su -s` 根据文档是指定运行的 shell，但 shell 收到的启动参数依旧是 `/system/bin/sh`

因此智能靠 `su -c` 替代。

为了防止奇怪的问题，这段内容需要你自己决定要不要加入 `/data/adb_home/.bashrc`。

```
alias su='su -p -c "bash --rcfile /data/adb_home/.bashrc"'
```

# 各种可能问题

## 不工作

 - 尝试在 rooted shell 里执行 `bash` 或 `/data/adb/modules/adb_shell/system/bin/bash` 如果不能执行表示：
 
1. 你的系统架构有问题，去跨平台编译一个 bash。如果你是在虚拟机中或者和电脑一个架构，直接把你自己在使用的 bash 复制过来也可以。

2. bash 权限有问题，将其设置 755 和正确的 SELinux 上下文（如果开了 SELinux）

 - 以 adb 进入 /data/adb_home 并 `cat .bashrc`如果不能执行，可能是文件夹权限或 SELinux 有问题
 
 - 不要用 su 2000 切换到 adb，这和原来的 adb SELinux 上下文不同。（你要是关了 SELinux 当我没说）
 
## 系统炸了：
 1. 在 Recovery 里删除或禁用此模块
`rm -rf /data/adb/modules/adb_bash` 或 `touch /data/adb/modules/adb_bash/disable`
2. 检查源 mkshrc 与本模块 mkshrc 开头部分是否相同（不同就复制粘贴掉模块内的部分）
