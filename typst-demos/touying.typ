// Touying 0.8.0 最小演示：一页中文内容页（16:9）
// 编译：typst compile --format png --ppi 130 touying.typ touying.png

#import "@preview/touying:0.8.0": *
#import themes.metropolis: *

#show: metropolis-theme.with(aspect-ratio: "16-9")

#set text(font: ("Libertinus Serif", "Noto Sans SC"), lang: "zh")

== 用 Typst 做幻灯片

- 一份纯文本源码：`==` 标题自动分页，版式交给主题统一管理
- 公式、代码高亮与 #alert[增量动画] 全都内置，不必安装插件
- 编译以毫秒计，改一个字就能立刻看到新的排版结果

#v(1.2em)

#alert[结论：幻灯片可以像写文档一样写出来。]
