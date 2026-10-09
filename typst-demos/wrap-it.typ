#set page(width: 13cm, height: auto, margin: 6pt, fill: white)
#set text(font: ("Libertinus Serif", "Noto Sans SC"), size: 9pt)

#import "@preview/wrap-it:0.1.1": wrap-top-bottom

// 被文字环绕的卡片完全由 Typst 绘制，不引用任何外部图片
#let card(tag, tint) = box(
  width: 4.2cm,
  inset: (x: 8pt, y: 7pt),
  radius: 5pt,
  fill: tint.lighten(88%),
  stroke: 0.7pt + tint.lighten(30%),
  grid(
    columns: (auto, 1fr),
    column-gutter: 8pt,
    align: horizon,
    circle(radius: 11pt, fill: tint),
    text(size: 8pt, fill: tint.darken(25%))[#tag],
  ),
)

// 一段连续的中文正文
#let passage = [
  Typst 是一门年轻的排版语言，它把标记、代码与数学公式放进同一套简洁的语法之中。与人们熟悉的老牌工具相比，Typst 的编译速度快得几乎让人忘记等待，增量编译更是把预览延迟压缩到可以忽略的程度。它的标准库自带页面、文本、表格、图形与绘图能力，绝大多数常见版式都不必再依赖第三方宏包。真正麻烦的需求往往只剩下一处：让文字自然而然地绕着一张插图流动。Typst 目前还没有原生的环绕功能，社区因此补上了 wrap-it 这样的方案。它的思路很直接，先把图形与正文放进同一个网格，再让正文在图形之外的列里换行，于是图形两侧都能排满文字，视觉效果和传统排版软件里的图文混排非常接近。两张卡片都由 Typst 0.15 自己画出来，没有 image，没有 svg，也没有 png，全部是 rect、circle 和 text 这些基础图形拼起来的。
]

// 上卡片靠左、下卡片靠右，文字从两张卡片中间穿过
#wrap-top-bottom(
  card([卡片 A], rgb("#2f6fb5")),
  card([卡片 B], rgb("#c2703a")),
  passage,
  top-kwargs: (column-gutter: 0.9em),
  bottom-kwargs: (column-gutter: 0.9em),
)
