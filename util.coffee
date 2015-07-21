fs = require 'fs'

exports = module.exports

functions = JSON.parse fs.readFileSync('functions.json')
exports.functions = functions

exports.THRESHOLD = 0.9 # number between -1 and 1

exports.POSITIVE = 1 # the value we are giving if api function is present
exports.NEGATIVE = 0 # the value if api function is NOT present

class Vector
  constructor: ->
    functions.forEach (fn) =>
      this[fn] = exports.NEGATIVE

exports.Vector = Vector