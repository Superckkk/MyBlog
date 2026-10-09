#set page(width: 13cm, height: auto, margin: 6pt, fill: white)
#set text(font: ("Libertinus Serif", "Noto Sans SC"), size: 9pt)
#set text(lang: "zh")

#import "@preview/showybox:2.0.4": showybox

#showybox(
  title: "showybox：自由定制的彩色盒子",
  frame: (
    title-color: rgb(63, 81, 181),
    body-color: rgb(232, 234, 246),
    border-color: rgb(48, 63, 159),
    radius: 6pt,
    thickness: 1.2pt,
  ),
  title-style: (
    color: white,
    weight: "bold",
    align: center,
  ),
  body-style: (
    color: rgb(26, 35, 126),
  ),
  shadow: (
    offset: 3pt,
    color: rgb(197, 202, 233),
  ),
  [它和 gentle-clues 的定位不一样。showybox 只提供「画盒子」的原语，标题栏配色、正文底色、边框粗细、圆角、阴影都要靠 `frame` 和 `title-style` 这类参数自己指定，适合需要贴合品牌配色或做一次性排版效果的场合；gentle-clues 则把配色、图标和标题都预设好了，写一句 `#info[...]` 就能得到语义化的提示框，适合写作过程中随手标注。],
)
