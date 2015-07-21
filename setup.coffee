fs = require 'fs'
path = require 'path'

fns = fs.readdirSync(__dirname + '/api')
#console.log(fns.sort())
functions = fns.map (fn) ->
  path.basename(fn, '.json')
#console.log functions
fs.writeFileSync('functions.json', JSON.stringify(functions))

util = require './util'

gists = {}
functions.forEach (fn) ->
  # read the file for each function
  data = JSON.parse fs.readFileSync __dirname + '/api/' + fn + '.json'

  blocks = Object.keys data.blocks
  console.log "processing #{blocks.length} blocks for #{fn}"
  blocks.forEach (block) ->
    gist = gists[block]
    if !gist
      gist = gists[block] = new util.Vector
    gist[fn] = util.POSITIVE

fs.writeFileSync "gists.json", JSON.stringify(gists)
