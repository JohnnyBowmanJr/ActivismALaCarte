app.views.ValidationView = Backbone.View.extend({

  tagName: 'div',
  id: 'verification',
  validationTemplate: JST['templates/validation'],
  events: {
  },

  render: function() {
    var html = this.validationTemplate({
      validation_code: this.options.validation_code,
      phone_number: this.options.phone_number
    });
    this.$el.html(html);
    return this;
  }
});
