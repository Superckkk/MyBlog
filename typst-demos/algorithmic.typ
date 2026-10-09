#set page(width: 13cm, height: auto, margin: 6pt, fill: white)
#set text(font: ("Libertinus Serif", "Noto Sans SC"), size: 9pt)

#import "@preview/algorithmic:1.0.7"
#import algorithmic: algorithm-figure, style-algorithm

// The algorithmicx look: fixed `procedure`/`if ... then`/`while ... do`/`end`
// keywords, auto indentation, a vertical guide stroke and line numbers.
#show: style-algorithm

#algorithm-figure("Binary Search", {
  import algorithmic: *
  Procedure("Binary-Search", ("A", "target"), {
    Comment[A is sorted in ascending order]
    Assign[$"low"$][$1$]
    Assign[$"high"$][$"A.length"$]
    While($"low" <= "high"$, {
      Assign[$"mid"$][FnInline[floor][$("low" + "high") / 2$]]
      IfElseChain(
        $"A"["mid"] = "target"$,
        { Return[$"mid"$] },
        $"A"["mid"] < "target"$,
        { Assign[$"low"$][$"mid" + 1$] },
        Assign[$"high"$][$"mid" - 1$],
      )
    })
    Return[*null*]
  })
})
