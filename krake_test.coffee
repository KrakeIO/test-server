# @Description : this is a data server where users will call to consume the data
#   Sample:
#     http://data.krake.io/1_grouponsgs/json?q={"limit"":10,"offset"":10,"parent_cat_id":"45","status":"Active","createdAt":{"gt":"2013-04-15"}}
express           = require 'express'
path              = require 'path'
fs                = require 'fs'
UnescapeStream    = require './lib/unescape_stream'



# Web Server section of system
app = module.exports = express.createServer();

app.configure ()->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'ejs'
  app.use express.bodyParser()
  app.use express["static"](__dirname + "/public")
  app.use app.router

# @Description : Indicates to the user that this is a Krake data server
app.get '/', (req, res)->
  res.render 'index'

# @Description : Indicates to the user that this is a Krake data server
app.get '/subpage/:page_id', (req, res)->
  res.render 'subpage', locals : { page_id: req.params.page_id }

# @Description : Indicates to the user that this is a Krake data server
app.get '/sibling/:page_id', (req, res)->
  res.render 'sibling', locals : { page_id: req.params.page_id }  

app.get '/json', (req, res)->
  ues = new UnescapeStream()  

  fs.createReadStream(__dirname + "/fixtures/mds_long")
  # fs.createReadStream(__dirname + "/fixtures/bad_string")
    .pipe ues
    .pipe res

module.exports = 
  app : app

if !module.parent
  # Start api server
  port = process.argv[2] || 10002
  app.listen port
  console.log "Test server listening at port : %s", port


