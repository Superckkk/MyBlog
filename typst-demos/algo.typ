#set page(width: 13cm, height: auto, margin: 6pt, fill: white)
#set text(font: ("Libertinus Serif", "Noto Sans SC"), size: 9pt)

#import "@preview/algo:0.3.6": algo, i, d, comment

// Algo typesets a content block: "\" ends a line, #i/#d open and close an
// indent level, keywords are auto-bolded, #comment puts a note on the line.
#algo(
  title: "Binary-Search",
  parameters: ("A", "target"),
  inset: 6pt,
  row-gutter: 3pt,
  column-gutter: 8pt,
  indent-size: 12pt,
  stroke: 0.5pt + luma(60%),
)[
  #comment(inline: true)[A is sorted in ascending order]\
  $"low" <- 1$\
  $"high" <- "A.length"$\
  while $"low" <= "high":#i\
    $"mid" <- "floor"(("low" + "high") / 2)$\
    if $"A"["mid"] = "target":#i\
      return $"mid"$#d\
    else if $"A"["mid"] < "target":#i\
      $"low" <- "mid" + 1$#d\
    else:#i\
      $"high" <- "mid" - 1$#d#d\
  return null
]
