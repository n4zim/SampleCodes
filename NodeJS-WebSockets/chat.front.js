// Inspired from :
// https://medium.com/@martin.sikora/node-js-websocket-simple-chat-tutorial-2def3a841b61

$(function() {
  "use strict"

  var content = $('#content')
  var input = $('#input')
  var status = $('#status')

  var myColor = false
  var myName = false

  window.WebSocket = window.WebSocket || window.MozWebSocket
  if(!window.WebSocket) {
    content.text('Your browser doesn\'t support WebSocket')
    input.hide()
    $('span').hide()
    return
  }

  var connection = new WebSocket('ws://127.0.0.1:8000')
  
  connection.onopen = function() {
    input.removeAttr('disabled')
    status.text('Name :')
  }

  connection.onerror = function(error) {
    content.html($('<p>', { text: 'Connection problem or server down' }))
  }
  
  connection.onmessage = function(message) {
    try {
      var json = JSON.parse(message.data)
    } catch (e) {
      console.log('Invalid JSON : ', message.data)
      return
    }

    if(json.type === 'color') { 
      myColor = json.data
      status.text(myName + ' : ').css('color', myColor)
      input.removeAttr('disabled').focus()
    
    } else if(json.type === 'history') {
      for (var i = 0; i < json.data.length; i++) {
          var current = json.data[i]
          addMessage(current.author, current.text, current.color, new Date(current.time))
      }
    
    } else if(json.type === 'message') {
      input.removeAttr('disabled') 
      var current = json.data;
      addMessage(current.author, current.text, current.color, new Date(current.time))
    
    } else {
      console.log('Hmm..., I\'ve never seen JSON like this:', json)
    }
  }

  input.keydown(function(e) {
    if(e.keyCode === 13) {
      var msg = $(this).val()
      if(!msg) return
      connection.send(msg)
      $(this).val('')
      input.attr('disabled', 'disabled')
      if(myName === false) {
        myName = msg
      }
    }
  })

  setInterval(function() {
    if(connection.readyState !== 1) {
      status.text('Error')
      input.attr('disabled', 'disabled').val('Unable to communicate with the WebSocket server.')
    }
  }, 3000)
  
  function addMessage(author, message, color, dt) {
    content.prepend('<p><span style="color:' + color + '">'
        + author + '</span> @ ' + (dt.getHours() < 10 ? '0'
        + dt.getHours() : dt.getHours()) + ':'
        + (dt.getMinutes() < 10
          ? '0' + dt.getMinutes() : dt.getMinutes())
        + ': ' + message + '</p>')
  }
})
