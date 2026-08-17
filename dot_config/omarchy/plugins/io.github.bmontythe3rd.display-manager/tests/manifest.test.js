const assert = require("assert")
const fs = require("fs")
const path = require("path")

const projectDir = path.join(__dirname, "..")
const manifest = JSON.parse(fs.readFileSync(path.join(projectDir, "manifest.json"), "utf8"))

assert.strictEqual(manifest.schemaVersion, 1)
assert.match(manifest.id, /^[a-z0-9]+(?:[.-][a-z0-9]+)+$/)
assert.match(manifest.version, /^\d+\.\d+\.\d+$/)
assert.ok(Array.isArray(manifest.kinds) && manifest.kinds.length > 0)
assert.ok(manifest.entryPoints && typeof manifest.entryPoints === "object")

const entryPointKeys = { "bar-widget": "barWidget" }
for (const kind of manifest.kinds) {
  const entryPoint = manifest.entryPoints[entryPointKeys[kind] || kind]
  assert.strictEqual(typeof entryPoint, "string", `missing entry point for ${kind}`)
  assert.ok(!path.isAbsolute(entryPoint) && !entryPoint.split(path.sep).includes(".."), `unsafe entry point for ${kind}`)
  assert.ok(fs.existsSync(path.join(projectDir, entryPoint)), `entry point does not exist for ${kind}`)
}

assert.ok(["left", "center", "right"].includes(manifest.barWidget.defaultSection))

console.log("manifest tests passed")
