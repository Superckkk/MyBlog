---
date: 2025-01-08
slug: pathlib-gotchas
categories:
  - Python
tags:
  - Python
  - pathlib
  - 标准库
authors:
  - your-name
---

# pathlib 用了三年，我还是会写错这几处

`pathlib` 是个好东西，但它的 API 有几处反直觉的地方，
每次隔一段时间不用就要重新踩一遍。这篇是占位内容，顺便当备忘。

<!-- more -->

## `/` 运算符右边的空字符串会吃掉整个路径

```python
from pathlib import Path

base = Path("/var/log/app")
print(base / "")
```

输出是 `/var/log/app` 而不是报错，看起来还挺贴心。问题是当这个空串
来自配置项时，你很难发现它是空的：

```python
def log_file(cfg: dict) -> Path:
    # cfg.get("subdir", "") 在没配置时返回 ""，
    # 于是 base / "" 静默地变成了 base，日志文件被写到了不该写的地方
    return Path(cfg["root"]) / cfg.get("subdir", "") / "app.log"
```

安全的写法是先归一化：

```python
def log_file(cfg: dict) -> Path:
    root = Path(cfg["root"])
    subdir = cfg.get("subdir") or ""
    return root / subdir / "app.log" if subdir else root / "app.log"
```

## `Path.with_suffix()` 遇到多点文件名会翻车

```python
>>> Path("archive.tar.gz").with_suffix(".zip")
PosixPath('archive.tar.zip')
```

只替换最后一个后缀。想换掉 `.tar.gz` 得自己拼：

```python
p = Path("archive.tar.gz")
p.with_name(p.name.removesuffix("".join(p.suffixes)) + ".zip")
# PosixPath('archive.zip')
```

## `glob("**/*.py")` 和 `rglob("*.py")` 不一样

`Path.glob("**/*.py")` 在 Python 3.13 之前**不包含隐藏目录**，
而且它不会匹配到符号链接指向的目录，除非显式加 `recurse_symlinks`。
`rglob("*.py")` 是 `glob("**/*.py")` 的简写，行为完全一样。

如果目录里有 `.venv`、`.git`，`rglob` 会把它们全扫一遍。
真要在项目里扫文件，一般用 `os.walk` 加手动剪枝更快：

```python
import os
from pathlib import Path

SKIP = {".git", ".venv", "node_modules", "__pycache__"}

def python_files(root: Path):
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = [d for d in dirnames if d not in SKIP]
        for name in filenames:
            if name.endswith(".py"):
                yield Path(dirpath) / name
```

## 读写文本时 `encoding` 一定要显式写

```python
Path("data.txt").read_text()          # 用 locale 编码，Windows 上是 cp936
Path("data.txt").read_text("utf-8")   # 明确一点
```

在 Linux 容器里跑得好好的代码，同事在 Windows 上克隆下来就 `UnicodeDecodeError`，
十有八九是这里。

同理 `write_text` 的 `newline` 参数默认是 `None`，
Windows 上会把 `\n` 翻译成 `\r\n`，跨平台生成配置文件时要注意。

## 相对路径不能跨盘符

```python
>>> Path("C:/a/b.txt").relative_to("D:/a")
ValueError: 'D:/a' is not a parent of 'C:/a/b.txt'
```

用 `os.path.relpath` 也不行，它同样跨不了盘。真要处理，只能先判断：

```python
def safe_relative(path: Path, base: Path) -> Path | None:
    try:
        return path.relative_to(base)
    except ValueError:
        return None
```

## 小结

| 写法 | 坑 |
| --- | --- |
| `p / ""` | 静默返回 `p` |
| `with_suffix` | 只换最后一个后缀 |
| `rglob("**")` | 扫进 `.venv`、`.git`，且默认不跟符号链接 |
| `read_text()` | 依赖 locale，跨平台不一致 |
| `relative_to` | 跨盘符直接抛异常 |

都是小事，但凑在一起能耗掉一个下午。有条件的项目直接上
`ruff` 的 `PTH` 规则集，能把 `os.path` 的写法统一迁到 `pathlib`，
至少风格上不会两种混着来。
