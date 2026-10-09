#set page(width: 13cm, height: auto, margin: 6pt, fill: white)
#set text(font: ("Libertinus Serif", "Noto Sans SC"), size: 9pt)

// timeliney 0.4.0：用 headerline 定义时间刻度，用 taskgroup / task 排布甘特条。
// 下面是一条 6 个月（2026 年 3—8 月）的排期，任务名用中文。
#import "@preview/timeliney:0.4.0"

#timeliney.timeline(
  show-grid: true,
  grid-style: (stroke: (dash: "dashed", thickness: 0.4pt, paint: rgb("#c0c6cc"))),
  line-style: (stroke: 9pt + rgb("#4b7bec")),
  {
    import timeliney: *

    headerline(group(([*2026 年*], 6)))
    headerline(group(..range(3, 9).map(m => [#m 月])))

    taskgroup(title: [*第一阶段：调研与设计*], {
      task("需求调研与竞品分析", (0, 1.5))
      task("原型设计与评审", (1.5, 3))
    })

    taskgroup(title: [*第二阶段：开发与测试*], {
      task("核心功能开发", (3, 5.5))
      task("联调与回归测试", (5, 6))
    })

    milestone(
      at: 3,
      style: (stroke: (dash: "dashed")),
      align(center, [*设计冻结*]),
    )
  },
)
