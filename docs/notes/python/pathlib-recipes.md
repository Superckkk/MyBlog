---
tags:
  - Python
  - pathlib
  - 笔记
---

# 常用 pathlib 片段

## 建目录（已存在不报错）

```python
from pathlib import Path

Path("out/reports").mkdir(parents=True, exist_ok=True)
```

`exist_ok=True` 只对目录有效。如果同名文件已存在，照样抛 `FileExistsError`。

## 递归扫文件，跳过一堆目录

```python
import os
from pathlib import Path

SKIP = {".git", ".venv", "node_modules", "__pycache__", ".mypy_cache"}

def walk_files(root: Path, suffix: str = ".py"):
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = sorted(d for d in dirnames if d not in SKIP)
        for name in sorted(filenames):
            if name.endswith(suffix):
                yield Path(dirpath) / name
```

用 `os.walk` 而不是 `rglob`，是因为只有它能**原地修改 `dirnames` 做剪枝**，
`rglob` 会把 `.venv` 整个扫一遍。

## 原子写文件

```python
import os
import tempfile
from pathlib import Path

def atomic_write(path: Path, data: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    fd, tmp = tempfile.mkstemp(dir=path.parent, prefix=f".{path.name}.", suffix=".tmp")
    try:
        with os.fdopen(fd, "w", encoding="utf-8", newline="\n") as f:
            f.write(data)
            f.flush()
            os.fsync(f.fileno())
        os.replace(tmp, path)
    except BaseException:
        os.unlink(tmp)
        raise
```

关键在于 `os.replace` 在同一文件系统内是原子的。
临时文件必须和目标文件在同一个目录，否则跨设备会退化成拷贝。

## 路径比较要归一化

```python
>>> Path("./a/b") == Path("a/b")
True
>>> Path("/tmp/a") == Path("/tmp/a/")
True
>>> Path("/tmp/../tmp/a") == Path("/tmp/a")
False          # 不解析 ..
```

要真正比较就用 `resolve()`（会访问文件系统）或者 `os.path.normpath`（纯字符串处理）：

```python
Path("/tmp/../tmp/a").resolve() == Path("/tmp/a").resolve()   # True
```

注意 `resolve()` 在 Windows 上会把盘符统一成大写，跨平台测试的时候要留神。

## 相对路径显示

在日志里打路径的时候，用相对路径更好读，但工作目录之外就退化成绝对路径：

```python
def pretty(path: Path, base: Path | None = None) -> str:
    base = (base or Path.cwd()).resolve()
    try:
        return str(path.resolve().relative_to(base))
    except ValueError:
        return str(path)
```

## 文件大小与时间

```python
stat = Path("data.bin").stat()
print(stat.st_size, stat.st_mtime)

from datetime import datetime, timezone
print(datetime.fromtimestamp(stat.st_mtime, tz=timezone.utc))
```

`st_mtime` 是秒级的浮点数，纳秒精度在 `st_mtime_ns` 里。
做增量同步判断的时候用后者，避免精度丢失。
