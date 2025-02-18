
// slides
#import "@preview/touying:0.5.3": *
#import themes.metropolis: *
// indent
#import "@preview/indenta:0.0.3": fix-indent
// theorems
#import "@preview/ctheorems:1.1.3": *
// physics
#import "@preview/physica:0.9.4": *
// banners
#import "@preview/gentle-clues:1.1.0": *
// subfigures
#import "@preview/subpar:0.2.1": grid as sgrid
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
// func return
#import "@preview/eqalc:0.1.3": *

#let conf(
  title: none,
  subtilte: none,
  author: (),
  author-size: 14pt,
  institute: none,
  background-img: "img/sky.png",
  footer: [],
  footer-size: 14pt,
  list-indent: 1.2em,
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
  set list(indent: list-indent)
  set enum(indent: list-indent)

  set page(background: image(background-img, width: 100%))

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

  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    it
  }

  show math.equation: it => {
    if it.has("label") {
      math.equation(
        block: true,
        numbering: n => {
          numbering("(1)", n)
        },
        it,
      )
    } else {
      it
    }
  }

  show ref: it => {
    let el = it.element
    if el != none and el.func() == math.equation {
      link(
        el.location(),
        numbering("(1)", counter(math.equation).at(el.location()).at(0) + 1),
      )
    } else {
      it
    }
  }

  show figure.caption: it => [
    #it.supplement
    #context it.counter.display(it.numbering)
    #it.body
  ]
  show figure.where(kind: table): set figure.caption(position: top)
  show link: underline

  show: codly-init.with()
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
    config-common(
      preamble: {
        codly(
          languages: codly-languages,
          display-name: false,
          fill: rgb("#F2F3F4"),
          number-format: none,
          zebra-fill: none,
          inset: (x: .3em, y: .2em),
          radius: .5em,
        )
      },
    ),
  )

  show: thmrules.with(qed-symbol: $square$)
  show: fix-indent()

  title-slide()
  outline(title: outline-title, indent: 2em, depth: 1)
  doc

  slide(align: center + horizon)[
    #text(ending, font: "Kaiti SC", size: 50pt)
  ]
}


// text
#let fonts = toml("fonts.toml")
#let ctext(body) = text(body, font: fonts.at("zh").math)

// tables
#let frame(stroke) = (
  (x, y) => (
    top: if y < 2 {
      stroke
    } else {
      0pt
    },
    bottom: stroke,
  )
)

// tables
#let frame2(stroke) = (
  (x, y) => (
    left: if x > 2 {
      stroke
    } else {
      0pt
    },
    top: stroke,
    bottom: stroke,
  )
)

#let ktable(data, k, inset: 0.3em) = table(
  columns: k,
  inset: inset,
  align: center + horizon,
  stroke: frame(rgb("000")),
  ..data.flatten(),
)

// codes
#let code(text, lang: "python", breakable: true, width: 100%) = block(
  fill: rgb("#F3F3F3"),
  stroke: rgb("#DBDBDB"),
  inset: (x: 1em, y: 1em),
  outset: -.3em,
  radius: 5pt,
  spacing: 1em,
  breakable: breakable,
  width: width,
  raw(
    text,
    lang: lang,
    align: left,
    block: true,
  ),
)

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

#let alert(title: "", icon: emoji.excl, ..args) = clue(
  accent-color: red,
  title: title,
  icon: icon,
  ..args,
)
