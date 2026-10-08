---
tags:
  - Git
  - 工具链
  - 笔记
---

# 我的 Git 别名

大扫除过一次，删掉了所有"抄来但从来没用过"的别名。
剩下的这些基本每天都会敲到。

## 查看

```ini
[alias]
    st = status -sb
    lg = log --oneline --graph --decorate -20
    last = log -1 --stat
    who = shortlog -sne --no-merges
```

`status -sb` 的 `-s` 是短格式，`-b` 带上分支信息，输出只有两行，
比默认的 `git status` 清爽得多。

`who` 用来快速看一个仓库都有谁在提交，接手别人的项目时很有用。

## 提交

```ini
[alias]
    amend = commit --amend --no-edit
    fixup = commit --fixup
    wip = commit -am "wip"
```

`--no-edit` 是关键。忘了加的话每次 `git amend` 都会弹编辑器。

## 撤销

```ini
[alias]
    unstage = restore --staged
    undo = reset --soft HEAD~1
    discard = restore
```

`undo` 只回退 commit，改动还在暂存区，比 `--hard` 安全。
真要丢掉改动，用 `discard` 之前先 `git st` 看清楚。

## 变基与清理

```ini
[alias]
    rb = rebase
    rbi = rebase -i
    cleanup = "!git branch --merged | grep -v '\\*\\|main\\|master' | xargs -r git branch -d"
```

`cleanup` 会删掉所有已经合并进当前分支的本地分支，
排除掉 `main` / `master` 和当前分支。

!!! warning "带 `!` 的别名是 shell 命令"

    这类别名会直接交给 shell 执行，Windows 上要装 Git Bash 才能用。
    写的时候注意引号转义，YAML 和 INI 都不是省油的灯。

## 一些配置

```ini
[init]
    defaultBranch = main

[push]
    default = current
    autoSetupRemote = true

[pull]
    ff = only
```

`pull.ff = only` 这个值得单独说：它禁止 `git pull` 产生合并提交。
要么快进，要么失败，逼你去想清楚到底要不要 merge。
团队里因为随手 `git pull` 弄出来的交叉合并提交，能少一大半。

`push.autoSetupRemote = true` 是 Git 2.37 之后才有的，
第一次推新分支不用再写 `-u origin xxx`。

## 别名的边界

别名适合**缩短**常用命令，不适合**封装流程**。
一旦某个别名需要传参数、需要判断条件，就该写成脚本放进 `PATH`，
而不是在 `.gitconfig` 里堆 `!sh -c '...'`。

前者能测试、能版本管理、能补全；后者只能靠记忆。
