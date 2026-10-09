#set page(width: 13cm, height: auto, margin: 6pt, fill: white)
#set text(font: ("Libertinus Serif", "Noto Sans SC"), size: 9pt)

#import "@preview/zebraw:0.6.3": zebraw

#let code = ```python
from functools import cache

@cache
def fib(n: int) -> int:
    """Return the n-th Fibonacci number."""
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)

print([fib(i) for i in range(10)])
```

// 语言标签绘制在代码块上边缘之上，留出这一段空白避免被页面裁掉
#v(1.4em)

#zebraw(
  lang: true,
  numbering-separator: true,
  highlight-lines: (3, 4),
  code,
)
