$(document).ready(function(){
  $('.like-btn').on('click', function(event) {
    event.preventDefault();

    var url = $(this).attr('href');
    $.post(url, function(error){
      if(error.message !== undefined)
      alert(error.message);
    }); // post is the POST method which is posting to the CREATE function for like
  });

  // var connection = new WebSocketRails('localhost:3000/websocket');
  // for deploying to Heroku
  var connection = new WebSocketRails(window.location.host + '/websocket');
  
  var likesChannel = connection.subscribe('likes');

  // post below is the data that was passed through in likes_controller WEBSOCKETS line
  likesChannel.bind('new', function(post){
    // console.log(post.new_like_count);
    // $('.like-btn').text('❤' + post.new_like_count);
    $('.like-btn[data-post-id=' + post.id + ']').text('❤ ' + post.new_like_count);
  });
});
