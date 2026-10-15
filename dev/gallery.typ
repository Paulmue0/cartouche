// Renders the README illustrations. Not part of the published package.
// typst compile gallery.typ ../docs/gallery-light.png --ppi 120
// typst compile gallery.typ ../docs/gallery-dark.png --ppi 120 --input theme=dark
#import "@local/cartouche:0.1.0": epigraph

#let dark = sys.inputs.at("theme", default: "light") == "dark"
#let bg = if dark { rgb("#1c1b1f") } else { white }
#let fg = if dark { rgb("#e8e6e3") } else { black }
#let dim = if dark { luma(60%) } else { luma(45%) }

#set page(width: 15cm, height: auto, margin: (x: 1.1cm, y: 1.1cm), fill: bg)
#set text(font: "Libertinus Serif", size: 10pt, fill: fg)
#show raw: set text(fill: dim, size: 0.85em)

#let sample(name, ..args) = {
  block(above: 0.9em, below: 0.4em, raw("style: \"" + name + "\""))
  epigraph(
    by: "Henry David Thoreau",
    from: "Walden",
    style: name,
    ..args,
  )[
    I went to the woods because I wished to live deliberately, to front only
    the essential facts of life.
  ]
}

#sample("classic")
#sample("latex-epigraph")
#sample("ruled")
#sample("bar")
#sample("marked")
#sample("dedication")
