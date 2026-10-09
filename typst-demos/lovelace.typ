#set page(width: 13cm, height: auto, margin: 6pt, fill: white)
#set text(font: ("Libertinus Serif", "Noto Sans SC"), size: 9pt)

#import "@preview/lovelace:0.3.1": pseudocode-list

// Lovelace is unopinionated: there is no keyword or comment construct at all.
// Every list item becomes one line, nesting becomes indentation, and keywords
// are just markup you style yourself. "//" must be escaped in markup mode.
#pseudocode-list[
  + *Binary-Search*(A, target)
  + \/\/ A is sorted in ascending order
  + low ← 1, high ← A.length
  + *while* low <= high
    + mid ← floor((low + high) / 2)
    + *if* A[mid] = target
      + *return* mid
    + *else if* A[mid] < target
      + low ← mid + 1
    + *else*
      + high ← mid - 1
    + *end*
  + *end*
  + *return* null
]
