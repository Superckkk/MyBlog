#set page(width: 13cm, height: auto, margin: 6pt, fill: white)
#set text(font: ("Libertinus Serif", "Noto Sans SC"), size: 9pt)

// syntree 0.3.1：用中括号嵌套语法画短语结构树。
// 第一个词是节点标签，其余内容是终端词；标签加 ^ 前缀表示无横线的三角形节点。
#import "@preview/syntree:0.3.1": syntree

#figure(
  gap: 0.5em,
  caption: [短语结构树示例],
  syntree(
    nonterminal: (style: "italic"),
    terminal: (fill: rgb("#1f4e79")),
    child-spacing: 1.2em,
    layer-spacing: 1.8em,
  )[
    [S
      [NP [Det The] [N cat]]
      [VP
        [V sat]
        [^PP on the mat]
      ]
    ]
  ],
)
