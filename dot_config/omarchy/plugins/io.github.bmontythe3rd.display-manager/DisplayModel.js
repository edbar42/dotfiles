.pragma library

function clone(value) { return JSON.parse(JSON.stringify(value)) }

function modeParts(mode) {
  var match = String(mode || "").match(/^(\d+)x(\d+)@(\d+(?:\.\d+)?)/)
  return match ? { width: Number(match[1]), height: Number(match[2]), refresh: Number(match[3]) } : null
}

function resolution(mode) {
  var p = modeParts(mode)
  return p ? p.width + "x" + p.height : ""
}

function refresh(mode) {
  var p = modeParts(mode)
  return p ? String(Math.round(p.refresh * 100) / 100) : ""
}

function canonicalMode(mode) {
  var p = modeParts(mode)
  return p ? p.width + "x" + p.height + "@" + (Math.round(p.refresh * 100) / 100) : String(mode || "preferred")
}

function modesForResolution(modes, wanted) {
  return (modes || []).filter(function(mode) { return resolution(mode) === wanted })
}

function refreshOptions(modes, wanted) {
  var seen = {}, result = []
  modesForResolution(modes, wanted).forEach(function(mode) {
    var value = refresh(mode)
    if (value && !seen[value]) {
      seen[value] = true
      result.push({ value: value, label: value + " Hz" })
    }
  })
  return result
}

function resolutions(modes) {
  var seen = {}, result = []
  ;(modes || []).forEach(function(mode) {
    var value = resolution(mode)
    if (value && !seen[value]) { seen[value] = true; result.push(value) }
  })
  return result
}

function resolutionOptions(modes) {
  var values = resolutions(modes)
  return values.map(function(value) {
    return {
      value: value,
      label: values.length === 1 ? value + " (native)" : value
    }
  })
}

function validScales(mode) {
  var p = modeParts(mode)
  if (!p) return [1]
  // Common integer, Windows-style, and fractional Wayland scales. Filter out
  // values that would create fractional logical pixels for the chosen mode.
  var candidates = [1, 1.2, 1.25, 4 / 3, 1.5, 1.6, 1.75, 2, 2.25, 2.5, 3, 4]
  return candidates.filter(function(scale) {
    return Math.abs(p.width / scale - Math.round(p.width / scale)) < 0.0001
      && Math.abs(p.height / scale - Math.round(p.height / scale)) < 0.0001
  })
}

function logicalSize(display) {
  var p = modeParts(display.mode) || { width: display.width || 0, height: display.height || 0 }
  var scale = Number(display.scale) || 1
  var rotated = Number(display.transform) % 2 === 1
  return {
    width: Math.round((rotated ? p.height : p.width) / scale),
    height: Math.round((rotated ? p.width : p.height) / scale)
  }
}

function overlap(a, b) {
  if (a.disabled || b.disabled || a.mirror || b.mirror) return false
  var as = logicalSize(a), bs = logicalSize(b)
  return a.x < b.x + bs.width && a.x + as.width > b.x
      && a.y < b.y + bs.height && a.y + as.height > b.y
}

function hasOverlap(displays) {
  for (var i = 0; i < displays.length; i++)
    for (var j = i + 1; j < displays.length; j++)
      if (overlap(displays[i], displays[j])) return true
  return false
}

function normalizePositions(displays) {
  var copy = clone(displays), minX = Infinity, minY = Infinity
  copy.forEach(function(d) {
    if (!d.disabled && !d.mirror) { minX = Math.min(minX, d.x); minY = Math.min(minY, d.y) }
  })
  if (!isFinite(minX)) return copy
  copy.forEach(function(d) {
    if (!d.disabled && !d.mirror) { d.x -= minX; d.y -= minY }
  })
  return copy
}

function nearestMode(modes, wantedResolution, wantedRefresh) {
  var choices = modesForResolution(modes, wantedResolution)
  if (!choices.length) return modes && modes.length ? modes[0] : "preferred"
  var target = Number(wantedRefresh), best = choices[0], distance = Infinity
  choices.forEach(function(mode) {
    var delta = Math.abs(Number(refresh(mode)) - target)
    if (delta < distance) { best = mode; distance = delta }
  })
  return canonicalMode(best)
}
