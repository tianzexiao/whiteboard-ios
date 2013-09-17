/* 
	Get the number of photos a user has and store it directly in the user table.
	This saves the clients an extra request for counting the photos.

	The afterSave method is triggered automatically every time a photo is
	uploaded so that it is always synced.
*/
Parse.Cloud.afterSave("Photo", function(request) {
  var user = userFromRequest(request);
  updateNumberOfPhotosForUser(user);
});

 Parse.Cloud.afterDelete("Photo", function(request) {
  var user = userFromRequest(request);
  updateNumberOfPhotosForUser(user);
});

function userFromRequest(request) {
  return request.object.get("user");
}

function updateNumberOfPhotosForUser(user) {
  getNumberOfPhotosFromUser(user, function(numberOfPhotos) {
  	user.set("numberOfPhotos", numberOfPhotos);
  	user.save();
  });
}

function getNumberOfPhotosFromUser(user, callback) {
  var query = new Parse.Query("Photo");
  query.equalTo("user", user);
  query.count({
	success: function(number) {
	  callback(number);
	}
  });
}