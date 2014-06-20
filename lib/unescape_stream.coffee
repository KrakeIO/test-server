util      = require 'util'
Transform = require('stream').Transform

UnescapeStream = (options)->
  @red_flag = false
  Transform.call @, options

util.inherits UnescapeStream, Transform

UnescapeStream.prototype._transform = (chunk, encoding, done)->
  new_data = []
  
  for character in chunk

    # If not escape character
    unless character == 92
      new_data.push character
      @red_flag = false

    # If this is the first escape after a stream of non escapes
    else if character == 92 && !@red_flag
      @red_flag = true
      new_data.push character

    # All subsequent escapes are ignored

  new_chunk = new Buffer new_data
  @push new_chunk
  done()

module.exports = UnescapeStream