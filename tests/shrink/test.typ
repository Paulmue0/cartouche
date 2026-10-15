// Visual regression: `width: auto` shrinks to the quote but never overflows.
#import "/lib.typ": epigraph

#set page(width: 10cm, height: auto, margin: 0.6cm)
#set text(font: "Libertinus Serif", size: 9pt)

#block(stroke: 0.4pt + red, epigraph(width: auto, style: "plain", by: "Anon.")[Short.])
#block(stroke: 0.4pt + red, epigraph(width: auto, style: "bar", by: "Anon.")[Short.])
#block(stroke: 0.4pt + red, epigraph(width: auto, style: "latex-epigraph", by: "Pindar", from: "Pythian Odes")[Short.])
#block(stroke: 0.4pt + red, epigraph(width: auto, style: "bar", by: "Anon.")[
  A much longer quotation that cannot fit on one line and so has to wrap
  inside the space that is actually available to it.
])
