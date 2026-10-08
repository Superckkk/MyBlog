---
tags:
  - Python
  - 笔记
---

# Python

标准库用得多，坑也就踩得多。这里放一些反复要查的片段。

## 常看的东西

- [常用 pathlib 片段](pathlib-recipes.md)
- [虚拟环境与依赖管理](#) —— 待写
- [asyncio 的几个陷阱](#) —— 待写

## 一条经验

标准库的默认值大多是为了"能用"，不是为了"用对"。
`open()` 的 `encoding`、`subprocess` 的 `shell`、`logging` 的 handler 继承，
默认值都有各自的年代背景，写生产代码时最好显式覆盖一遍。
