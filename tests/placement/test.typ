// Visual regression: position, anchor, float and nudging.
#import "/lib.typ": epigraph

#set page(width: 11cm, height: 9cm, margin: 1.2cm)
#set text(font: "Libertinus Serif", size: 8pt)

#epigraph(position: top + end, width: 35%, style: "plain")[top + end]
#epigraph(position: bottom + start, width: 35%, style: "bar")[bottom + start]
#epigraph(position: horizon + center, width: auto, style: "ruled")[horizon + center]
#epigraph(position: start, dx: -1cm, width: 2cm, style: "plain")[nudged]
#epigraph(position: top, anchor: "page", dy: 4mm, width: auto, style: "plain")[page top]
#epigraph(position: bottom, anchor: "page", dy: -4mm, width: auto, style: "plain")[page bottom]

#pagebreak()

#epigraph(position: top, float: true, style: "ruled", by: "Anon.")[Floating above.]
#lorem(30)
#epigraph(position: bottom, float: 3em, style: "ruled", by: "Anon.")[Floating below, 3em clearance.]
