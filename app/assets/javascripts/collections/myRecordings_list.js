app.collections.MyRecordingsList = Backbone.Collection.extend({

  model: app.models.MyRecording,
  url: '/users/my_recordings_list'
});