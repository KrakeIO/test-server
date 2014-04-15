# @Description : this is a data server where users will call to consume the data
#   Sample:
#     http://data.krake.io/1_grouponsgs/json?q={"limit"":10,"offset"":10,"parent_cat_id":"45","status":"Active","createdAt":{"gt":"2013-04-15"}}
express           = require 'express'
path              = require 'path'


# Web Server section of system
app = module.exports = express.createServer();

app.configure ()->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'ejs'
  app.use express.bodyParser()
  app.use app.router

# @Description : Indicates to the user that this is a Krake data server
app.get '/', (req, res)->
  res.render 'index'

module.exports = 
  app : app

if !module.parent
  # Start api server
  port = process.argv[2] || 10001
  app.listen port
  console.log "Test server listening at port : %s", port


