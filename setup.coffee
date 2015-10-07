fs = require 'fs'
path = require 'path'

dir = process.argv[2] || __dirname + '/api'

fns = fs.readdirSync(dir)
#console.log(fns.sort())
functions = []
fns.forEach (fn) ->
  if fn.indexOf('.json') > 0
    functions.push path.basename(fn, '.json')
#console.log functions
fs.writeFileSync('functions.json', JSON.stringify(functions))

util = require './util'

gists = {}
blocks = {}
blockArray = []
functions.forEach (fn) ->
  # read the file for each function
  data = JSON.parse fs.readFileSync path.join(dir, fn + '.json')

  blockIds = Object.keys data.blocks
  console.log "processing #{blockIds.length} blocks for #{fn}"
  blockIds.forEach (blockId) ->
    gist = gists[blockId]
    if !gist
      gist = gists[blockId] = new util.Vector
    gist[fn] = util.POSITIVE

    block = blocks[blockId]
    if !block
      block = blocks[blockId] = data.blocks[blockId]

blockIds = Object.keys blocks
blockIds.forEach (blockId) ->
  block = blocks[blockId]
  block.id = blockId
  delete block.count
  #block.api = gists[blockId]
  vec = gists[blockId]
  api = {}
  functions.forEach (fn) ->
    if vec[fn]
      api[fn] = vec[fn]
  block.api = api
  blockArray.push block

fs.writeFileSync "gists.json", JSON.stringify(gists)
fs.writeFileSync "blocks.json", JSON.stringify(blockArray)
