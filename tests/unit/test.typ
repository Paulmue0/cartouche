// Unit tests: the parts of the package that are plain data.
#import "/lib.typ": epigraph, epigraph-frames, epigraph-presets

// Every preset is complete: same keys as every other preset.
#let keys = epigraph-presets.plain.keys().sorted()
#for (name, preset) in epigraph-presets {
  assert.eq(
    preset.keys().sorted(),
    keys,
    message: "preset " + name + " does not have the standard set of keys",
  )
}

// The documented defaults.
#assert.eq(epigraph-presets.classic.width, 40%)
#assert.eq(epigraph-presets.classic.align, end)
#assert.eq(epigraph-presets.latex-epigraph.divider, true)
#assert.eq(epigraph-presets.latex-epigraph.accent, auto)
#assert.eq(epigraph-presets.bar.accent, luma(70%))
#assert.eq(epigraph-presets.plain.divider, false)

// Every frame is a function, and every preset points at one.
#for (name, frame) in epigraph-frames {
  assert.eq(type(frame), function, message: "frame " + name + " is not a function")
}
#for (name, preset) in epigraph-presets {
  assert.eq(type(preset.frame), function, message: "preset " + name + " has no frame")
}

// A partial style dictionary is filled in from the defaults.
#let partial = epigraph(style: (width: 50%), by: "Anon.")[Partial.]
#assert.ne(partial, none)
