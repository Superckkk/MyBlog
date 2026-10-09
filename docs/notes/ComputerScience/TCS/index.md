---
tags:
  - 理论计算机科学
  - 自动机
---

# 理论计算机科学（Language and Automaton）

一份 34 页的课程讲义，从布尔函数一路讲到通用图灵机。下面嵌了站内阅读器，
也可以直接[下载 PDF](TCS.pdf)存本地。

<div class="pdf-viewer">
  <iframe src="TCS.pdf" title="Language and Automaton 讲义"></iframe>
</div>

## 讲义大纲

顺着从「能算什么」到「算不动什么」这条线走：

| 层次 | 内容 |
| --- | --- |
| 起点 | Boolean Function、Language |
| 正则语言 | DFA、NFA、Regular Expression |
| 上下文无关 | Grammar、CFG、PDA、CFL |
| 可计算性 | Turing Machine、Universal Turing Machine |
| 计算模型等价 | NAND-TM、NAND-RAM |

## 几条主线

**DFA 与 NFA 的等价**——非确定性看起来更强，但子集构造法说明任何 NFA
都能转成等价的 DFA，两者识别的语言类完全一样。

**正则表达式的边界**——它和有限自动机描述的是同一类语言。
像 $\\{0^n 1^n \\mid n \\ge 0\\}$ 这种需要「数数」的语言，
有限状态记不住，就得往上走到上下文无关文法。

**CFG 与 PDA**——和上一层的对应关系一模一样：文法生成语言，
下推自动机识别语言，多出来的那个栈就是上下文无关能力的来源。

**通用图灵机**——把图灵机本身编码成输入，一台机器就能模拟所有机器。
这是「可编程计算机」这个概念的理论原型，也是停机问题能成立的前提。
