fs = require 'fs'

{POSITIVE, NEGATIVE, THRESHOLD, Vector, functions} = require './util'

gists = JSON.parse fs.readFileSync('gists.json')

gistIds = Object.keys gists
console.log "number of gists", gistIds.length


testv = new Vector
testv['d3.geo'] = POSITIVE
#testv['d3.geo.path'] = POSITIVE
testv['d3.geo.azimuthal'] = POSITIVE

cosineSimilarity = (u, v) ->
  # u is the user's vector we are testing for similarity
  # v is the gist's vector we are checking against
  # first we take the dot product
  udotv = 0
  umag = 0
  vmag = 0
  functions.forEach (fn) ->
    udotv += u[fn] * v[fn]
    umag += u[fn]*u[fn]
    vmag += v[fn]*v[fn]
  umag = Math.sqrt(umag)
  vmag = Math.sqrt(vmag)
  return udotv/(umag*vmag)


matches = []
gistIds.forEach (gid) ->
  #console.log gists[gid]
  gistv = gists[gid]
  costheta = cosineSimilarity(testv, gistv)
  matches.push {gistId: gid, similarity: costheta}
  # if costheta > THRESHOLD
  #   matches.push {gistId: gid, similarity: costheta}

matches.sort (a,b) ->
  return b.similarity - a.similarity

console.log "top matches\n", matches.slice(0, 10)
#console.log matches.length + " matches found with similarity greater than #{THRESHOLD}"

