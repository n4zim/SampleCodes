// Inspired from :
// https://medium.com/@martin.sikora/node-js-websocket-simple-chat-tutorial-2def3a841b61

const WebSocketServer = require('websocket').server
const http = require('http')

let history = []
const clients = []

const convertSpecialChars = string => String(string)
  .replace(/&/g, '&amp')
  .replace(/</g, '&lt')
  .replace(/>/g, '&gt')
  .replace(/"/g, '&quot')

const log = message => console.log(`[${new Date()}] ${message}`)

const colors = [ 'red', 'green', 'blue', 'magenta', 'purple', 'plum', 'orange' ]
colors.sort((a, b) => Math.random() > 0.5)

const server = http.createServer()
server.listen(8000, () => {
  log("Server started on port 8000")
})

var wsServer = new WebSocketServer({
  httpServer: server,
})

wsServer.on('request', request => {
  log(`Connection from origin ${request.origin}...`)

  const connection = request.accept(null, request.origin) 

  const index = clients.push(connection) - 1
  let userName = false
  let userColor = false

  log('Connection accepted !')

  if(history.length > 0) {
    connection.sendUTF(JSON.stringify({ type: 'history', data: history }))
  }

  connection.on('message', message => {
    if(message.type === 'utf8') {
     if(userName === false) {
        userName = convertSpecialChars(message.utf8Data)
        
        userColor = colors.shift()
        connection.sendUTF(JSON.stringify({ type:'color', data: userColor }))
        
        log(`User is known as ${userName} with ${userColor} color`)
      } else {
        log(`Received message from ${userName} : ${message.utf8Data}`)
        
        const current = {
          time: (new Date()).getTime(),
          text: convertSpecialChars(message.utf8Data),
          author: userName,
          color: userColor,
        }

        history.push(current)
        history = history.slice(-100)

        const json = JSON.stringify({ type:'message', data: current })
        for(var i = 0; i < clients.length; i++) {
          clients[i].sendUTF(json)
        }
      }
    }
  })

  connection.on('close', connection => {
    if(userName !== false && userColor !== false) {
      log(`Peer ${connection.remoteAddress} disconnected`)
      clients.splice(index, 1)
      colors.push(userColor)
    }
  })
})
