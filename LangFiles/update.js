const fs = require("fs");
const path = require("path");
const luaparse = require("luaparse");

const keys = {};

let hasPlaceholders = false
let placeholders

if (process.argv.length >= 3){
  hasPlaceholders = true
  let oldFile = fs.readFileSync("LangFiles/"+process.argv[2]+".json", {encoding: "utf8"})
  placeholders = JSON.parse(oldFile)
}

function getPlaceholder(key, argAmount){
  if (hasPlaceholders && placeholders[key] !== undefined) {
    return "!!! " + placeholders[key] + " !!!"
  }
  else {
    if (argAmount === 2) {
      return "!!! TRANSLATE w/ " + argAmount + " args !!!";
    }
    else
    {
      return "!!! TRANSLATE !!!";
    }
  }
}

function walk(node) {
  if (!node || typeof node !== "object") return;

  if (node.type === "CallExpression") {
    const base = node.base;

    // lang.Lang("key", ...)
    if (
      base.type === "MemberExpression" &&
      base.indexer === "." &&
      base.base.type === "Identifier" &&
      base.base.name === "lang" &&
      base.identifier.name === "Lang" &&
      node.arguments.length > 0 &&
      node.arguments[0].type === "StringLiteral"
    ) {
      let name = node.arguments[0].raw.substring(1, node.arguments[0].raw.length-1)
      if (node.arguments.length === 2) {
        keys[name] = getPlaceholder(name, node.arguments[1].fields.length);
      }
      else
      {
        keys[name] = getPlaceholder(name, 0);
      }
    }
  }

  for (const k in node) {
    const v = node[k];
    if (Array.isArray(v)) v.forEach(walk);
    else walk(v);
  }
}

function scanFile(file) {
    const code = fs.readFileSync(file, "utf8");
    try {
        const ast = luaparse.parse(code, { luaVersion: "5.2" });
        walk(ast);
    } catch (e) {
        console.error("Parse error:", file, e.message);
    }
}

function scanDir(dir) {
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
        const p = path.join(dir, entry.name);
        if (entry.isDirectory())
            scanDir(p);
        else if (p.endsWith(".lua"))
            scanFile(p);
    }
}

scanDir("./Lua");

let mergeWith = process.argv[3]

if (process.argv.length === 4){
  let oldFile = fs.readFileSync("LangFiles/"+mergeWith+".json", {encoding: "utf8"})
  let oldData = JSON.parse(oldFile)
  for (const [key, value] of Object.entries(oldData)) {
    keys[key] = value;
  }
}

fs.writeFileSync("LangFiles/lang_keys.json", JSON.stringify(keys, Object.keys(keys).sort(), 4));
console.log(`Found ${Object.keys(keys).length} keys`);
