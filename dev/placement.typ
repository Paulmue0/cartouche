// Renders docs/placement.png for the README: where `position` puts an
// epigraph, against the text area and against the paper.
// Not part of the published package.
#import "@local/cartouche:0.1.0": epigraph

#set page(width: 10cm, height: 7.5cm, margin: 1.4cm)
#set text(font: "Libertinus Serif", size: 7.5pt)

#let area = place(top + left, rect(
  width: 100%,
  height: 100%,
  stroke: (paint: luma(78%), dash: "dashed", thickness: 0.5pt),
))

#let caption(body) = place(top + left, dy: -0.62cm, text(size: 8pt, fill: luma(35%), body))

#let spot(pos, code, ..args) = epigraph(
  style: "plain",
  width: auto,
  above: 0pt,
  below: 0pt,
  position: pos,
  ..args,
)[#raw(code)]

// Against the text area: the default.
#caption[`anchor: "area"` — the text area (the default)]
#area
#spot(top + start, "top + start")
#spot(top + center, "top + center")
#spot(top + end, "top + end")
#spot(horizon + start, "horizon + start")
#spot(horizon + center, "horizon + center")
#spot(horizon + end, "horizon + end")
#spot(bottom + start, "bottom + start")
#spot(bottom + center, "bottom + center")
#spot(bottom + end, "bottom + end")

#pagebreak()

// Against the paper, margins included. `dx`/`dy` hold it off the edge.
#let pin(pos, code, inset: 3mm) = spot(
  pos,
  code,
  anchor: "page",
  dx: if pos.x == left { inset } else if pos.x == right { -inset } else { 0pt },
  dy: if pos.y == top { inset } else if pos.y == bottom { -inset } else { 0pt },
)

#caption[`anchor: "page"` — the whole sheet, margins included]
#area
#pin(top + left, "top + left")
#pin(top + center, "top + center")
#pin(top + right, "top + right")
#pin(horizon + left, "horizon + left")
#pin(horizon + center, "horizon + center")
#pin(horizon + right, "horizon + right")
#pin(bottom + left, "bottom + left")
#pin(bottom + center, "bottom + center")
#pin(bottom + right, "bottom + right")
