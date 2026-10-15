// Visual regression: every preset, with and without an attribution.
#import "/lib.typ": epigraph, epigraph-presets

#set page(width: 12cm, height: auto, margin: 0.6cm)
#set text(font: "Libertinus Serif", size: 9pt)

#for name in epigraph-presets.keys() {
  raw(name)
  epigraph(style: name, by: "Henry David Thoreau", from: "Walden")[
    I went to the woods because I wished to live deliberately.
  ]
  epigraph(style: name)[Without an attribution.]
}
