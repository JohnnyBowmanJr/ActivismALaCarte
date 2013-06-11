app.views.CampaignChartView = Backbone.View.extend({

  render: function() {

    var today = moment().format("MMM-Do");
    var yesterday = moment().subtract('days', 1).format("MMM-Do");
    var twoDays = moment().subtract('days', 2).format("MMM-Do");
    var threeDays = moment().subtract('days', 3).format("MMM-Do");
    var fourDays = moment().subtract('days', 4).format("MMM-Do");
    var fiveDays = moment().subtract('days', 5).format("MMM-Do");

    new Morris.Line({
      // ID of the element in which to draw the chart.
      element: 'call-chart-' + String(this.model.attributes.id),
      // Chart data records -- each entry in this array corresponds to a point on
      // the chart.

      data: [
        { year: fiveDays, value: this.model.attributes.five_days_calls },
        { year: fourDays, value: this.model.attributes.four_days_calls },
        { year: threeDays, value: this.model.attributes.three_days_calls },
        { year: twoDays, value: this.model.attributes.two_days_calls },
        { year: yesterday, value: this.model.attributes.one_day_calls },
        { year: today, value: this.model.attributes.today_calls }
      ],
      // The name of the data record attribute that contains x-values.
      xkey: 'year',
      // A list of names of data record attributes that contain y-values.
      ykeys: ['value'],
      // Labels for the ykeys -- will be displayed when you hover over the
      // chart.
      labels: ['Value'],

      parseTime: false

    });
  }

});