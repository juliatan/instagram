$(document).ready(function(){
  $('.like-btn').on('click', function(event) {
    event.preventDefault();

    var url = $(this).attr('href');
    $.post(url); // post is the POST method which is posting to the CREATE function for like

    var connection = new WebSocketRails('localhost:3000/websocket');
    var likesChannel = connection.subscribe('likes');
    
    // post below is the data that was passed through in likes_controller WEBSOCKETS line
    likesChannel.bind('new', function(post){
      console.log(post.new_like_count);
    })
  })
})
