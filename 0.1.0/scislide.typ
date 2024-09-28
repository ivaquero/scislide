// slides
#import "@preview/touying:0.5.2": *
#import themes.metropolis: *
// indent
#import "@preview/indenta:0.0.3": fix-indent
// physics
#import "@preview/physica:0.9.2": *
// theorems
#import "@preview/ctheorems:1.1.2": *
// banners
#import "@preview/gentle-clues:1.0.0": *
// figures
#import "@preview/subpar:0.1.1": grid as sgrid

#let conf(
  title: none,
  subtilte: none,
  author: (),
  author-size: 14pt,
  institute: none,
  footer: [],
  footer-size: 14pt,
  outline-title: [内容提要],
  ending: [感谢大家聆听],
  doc,
) = {
  set text(font: "Songti SC", weight: "light", size: 20pt)
  set par(
    first-line-indent: 2em,
    justify: true,
    leading: 1em,
    linebreaks: "optimized",
  )
  set block(above: 1em, below: 0.5em)
  set math.equation(numbering: "(1)")
  set ref(supplement: it => {
    if it.func() == table {
      it.caption
    } else if it.func() == image {
      it.caption
    } else if it.func() == figure {
      it.supplement
    } else if it.func() == math.equation { } else { }
  })

  show link: underline
  show: metropolis-theme.with(
    aspect-ratio: "16-9",
    footer: text(footer, size: footer-size, font: "Kaiti SC"),
    config-info(
      title: [#text(title, size: 40pt)],
      subtitle: [#subtilte],
      author: [#text(author, size: author-size, font: "Kaiti SC")],
      date: datetime.today(),
      institution: [institution],
      logo: emoji.school,
    ),
    config-methods(
      cover: utils.semi-transparent-cover.with(alpha: 80%),
    ),
    config-colors(
      primary-light: rgb("#fcbd00"),
      secondary: rgb("#3297df"),
      secondary-light: rgb("#ff0000"),
      neutral-lightest: rgb("#ffffff"),
      neutral-dark: rgb("#3297df"),
    ),
  )

  show: thmrules
  show: fix-indent()

  title-slide()
  outline(title: "内容提要", indent: auto, depth: 1)
  doc

  focus-slide[
    #text(ending, font: "Kaiti SC", size: 40pt)
  ]
}

// theorems
#let terms = (
  "def": "定义",
  "theo": "定理",
  "lem": "引理",
  "coro": "推论",
  "rule": "法则",
  "algo": "算法",
  "tip": "提示",
  "alert": "注意",
)

#let definition = thmbox(
  "definition",
  terms.def,
  base_level: 1,
  separator: [#h(0.5em)],
  padding: (top: 0em, bottom: 0em),
  fill: rgb("#FFFFFF"),
  // stroke: rgb("#000000"),
  inset: (left: 0em, right: 0.5em, top: 0.2em, bottom: 0.2em)
)

#let theorem = thmbox(
  "theorem",
  terms.theo,
  base_level: 0,
  separator: [#h(0.0em)],
  padding: (top: 0em, bottom: 0.0em),
  fill: rgb("#E5EEFC"),
  stroke: rgb("#000000"),
)

#let lemma = thmbox(
  "theorem",
  terms.lem,
  separator: [#h(0.5em)],
  fill: rgb("#EFE6FF"),
  titlefmt: strong,
)

#let corollary = thmbox(
  "corollary",
  terms.coro,
  base: "theorem",
  separator: [#h(0.5em)],
  titlefmt: strong,
)

#let rule = thmbox(
  "",
  terms.rule,
  base_level: 1,
  separator: [#h(0.5em)],
  fill: rgb("#EEFFF1"),
  titlefmt: strong,
)

#let tip = thmbox(
 "",
 none,
 fill: rgb("#FFFEE6"),
 radius: 0.5em,
 padding: (top: 0em, bottom: 0em),
 separator: [],
 // stroke: rgb("#000000")
).with(numbering: none)

#let algo = thmbox(
 "",
 terms.algo,
 fill: rgb("#FAF2FB"),
 radius: 0em,
 padding: (top: 0em, bottom: 0em),
 separator: [],
 // stroke: rgb("#000000")
)

// banners
#let tip(title: "", icon: emoji.lightbulb, ..args) = clue(
  accent-color: rgb("#ffe66b"),
  title: title,
  icon: icon,
  ..args,
)

#let alert(title: linguify("alert"), icon: emoji.excl, ..args) = clue(
  accent-color: red,
  title: title,
  icon: icon,
  ..args,
)
