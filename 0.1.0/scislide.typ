
// slides
#import "@preview/touying:0.5.3": *
#import themes.metropolis: *
// indent
#import "@preview/indenta:0.0.3": fix-indent
// checklist
#import "@preview/cheq:0.2.2": checklist
// physics
#import "@preview/physica:0.9.4": *
// theorems
#import "@preview/ctheorems:1.1.3": *
// banners
#import "@preview/gentle-clues:1.1.0": *
// subfigures
#import "@preview/subpar:0.2.0": grid as sgrid
// diagram
#import "@preview/fletcher:0.5.4": diagram, node, edge
#import "@preview/cetz-plot:0.1.1": *
// codes
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.6": *
// annot
#import "@preview/pinit:0.2.2": *
// excel
#import "@preview/rexllent:0.3.0": xlsx-parser

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
  set par(
    first-line-indent: 2em,
    justify: true,
    leading: 1em,
    linebreaks: "optimized",
  )
  set block(above: 1em, below: 0.5em)
  set math.equation(numbering: "(1)")

  let fonts = toml("fonts.toml")
  set text(
    font: fonts.at("zh").context,
    weight: "light",
    size: 20pt,
  )

  set ref(
    supplement: it => {
      if it.func() == table {
        it.caption
      } else if it.func() == image {
        it.caption
      } else if it.func() == figure {
        it.supplement
      } else if it.func() == math.equation { } else { }
    },
  )

  show figure.caption: it => [
    #it.supplement
    #context it.counter.display(it.numbering)
    #it.body
  ]
  show figure.where(kind: table): set figure.caption(position: top)

  codly(
    languages: codly-languages,
    fill: rgb("#F2F3F4"),
    zebra-fill: none,
    inset: (x: .3em, y: .2em),
    stroke: -1pt + rgb("#000000"),
    radius: .5em,
  )
  show: codly-init.with()

  show link: underline
  show: metropolis-theme.with(
    aspect-ratio: "16-9",
    footer: text(footer, size: footer-size, font: fonts.at("zh").footer),
    config-info(
      title: [#text(title, size: 40pt)],
      subtitle: [#subtilte],
      author: [#text(author, size: author-size, font: fonts.at("zh").author)],
      date: datetime.today(),
      institution: [#institute],
      logo: emoji.school,
    ),
    config-methods(cover: utils.semi-transparent-cover.with(alpha: 80%)),
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
  inset: (left: 0em, right: 0.5em, top: 0.2em, bottom: 0.2em),
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
