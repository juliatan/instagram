$(document).ready(function(){

  var postId = $('#map').data('id');

  if(postId) {
    $.get('/posts/'+postId+'.json', function(post){
      
      var map = new GMaps({
        div: '#map',
        lat: 0,
        lng: 0
      });

  // post no longer @post because of function(post) above... it is now the json
      GMaps.geocode({
        address: post.address,
        callback: function(results, status) {
          if (status == 'OK') {
            var latlng = results[0].geometry.location;
            map.setCenter(latlng.lat(), latlng.lng());
            map.addMarker({
              lat: latlng.lat(),
              lng: latlng.lng()
            });
          }
        }
      });
    });
  }

});