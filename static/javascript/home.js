// Generated by CoffeeScript 1.10.0
(function() {
  var contactForm, ratingWidget;

  ratingWidget = (function() {
    var catchDom, defaults, dom, events, initialize, st, suscribeEvents;
    dom = {};
    st = {};
    defaults = {
      body: 'body, html',
      stars: '#rating #stars',
      counter: "#rating .counter"
    };
    catchDom = function(st) {
      dom.body = $(st.body);
      dom.stars = $(st.stars);
      dom.counter = $(st.counter);
    };
    suscribeEvents = function() {
      dom.stars.rateYo('option', 'onChange', events.onChange);
    };
    events = {
      initPlugin: function() {
        dom.stars.rateYo({
          halfStar: true,
          spacing: "10px",
          normalFill: "#EAEAEA",
          starWidth: "40px"
        });
      },
      onChange: function(rating, rateYoInstance) {
        var posleft, rating_tool_tip;
        rating_tool_tip = null;
        if (rating > 0) {
          $(this).prev().text(rating);
          $(this).prev().show();
          posleft = 19.5;
          if (rating > 4) {
            posleft = 45 + 25.2;
          } else if (rating > 3) {
            posleft = 45 + 12.3;
          } else if (rating > 2) {
            posleft = 45;
          } else if (rating > 1) {
            posleft = 45 - 13;
          }
          clearTimeout(rating_tool_tip);
          $(this).prev().css({
            left: posleft + '%'
          });
          return rating_tool_tip = setTimeout(function() {
            return dom.counter.fadeOut();
          }, 2000);
        }
      }
    };
    initialize = function(opts) {
      st = $.extend({}, defaults, opts);
      catchDom(st);
      events.initPlugin();
      return suscribeEvents();
    };
    return {
      init: initialize
    };
  })();

  ratingWidget.init();

  contactForm = (function() {
    var catchDom, defaults, dom, events, initialize, st, suscribeEvents;
    dom = {};
    st = {};
    defaults = {
      body: 'body, html',
      form: '.contact-form'
    };
    catchDom = function(st) {
      dom.body = $(st.body);
      dom.form = $(st.form);
    };
    suscribeEvents = function() {};
    events = {
      initValidation: function() {
        return dom.form.validate({
          errorElement: 'p',
          errorPlacement: events.errorPlacement,
          onfocusout: events.onfocusOut,
          rules: {
            email: {
              required: true,
              email: true
            },
            name: {
              required: true
            },
            subject: {
              required: true
            },
            description: {
              required: true
            },
            team: {
              required: true
            }
          }
        });
      },
      onfocusOut: function(element) {
        if (this.element(element)) {
          $(element).parent().parent().removeClass('input-field-error');
          return $(element).parent().parent().find('.error-box').fadeOut('fast');
        }
      },
      errorPlacement: function(error, element) {
        $(element).parent().parent().addClass('input-field-error');
        return $(element).parent().parent().find('.error-box').fadeIn('slow');
      },
      submitHandler: function() {
        return console.log('submit');
      }
    };
    initialize = function(opts) {
      st = $.extend({}, defaults, opts);
      catchDom(st);
      events.initValidation();
      return suscribeEvents();
    };
    return {
      init: initialize
    };
  })();

  contactForm.init();

}).call(this);
