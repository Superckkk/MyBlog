#set page(width: 13cm, height: auto, margin: 6pt, fill: white)
#set text(font: ("Libertinus Serif", "Noto Sans SC"), size: 9pt)

// finite 0.5.1：用状态转移表描述有限自动机，自动生成状态图。
// 该 DFA 接受以 "01" 结尾的二进制串：q0 为起始状态，q1 与 q2 带自环。
#import "@preview/finite:0.5.1": automaton

#automaton(
  (
    q0: (q0: "1", q1: "0"),
    q1: (q1: "0", q2: "1"),
    q2: (q1: "0", q2: "1"),
  ),
  initial: "q0",
  final: "q2",
  labels: (q0: [Start], q1: [$q_1$], q2: [Accept]),
  layout: (q0: (0, 0), q1: (2.9, 0), q2: (5.8, 0)),
)
