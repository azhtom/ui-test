# Test
# by @azhtom

ratingWidget = (->
    dom = {}
    st = {}
    defaults =
        body : 'body, html'
        stars : '#rating #stars'
        counter: "#rating .counter"
    catchDom = (st) ->
        dom.body = $(st.body)
        dom.stars = $(st.stars)
        dom.counter = $(st.counter)
        return
    suscribeEvents = ->
        #dom.btnOpen.on 'click', events.getMenu
        dom.stars.rateYo 'option', 'onChange', events.onChange
        return
    events =
        initPlugin: () ->
            dom.stars.rateYo(
                halfStar    : true
                spacing     : "10px"
                normalFill  : "#EAEAEA"
                starWidth   : "40px"
            )
            return
        onChange: (rating, rateYoInstance) ->
            rating_tool_tip = null
            if rating > 0
                $(this).prev().text(rating)
                $(this).prev().show()

                posleft = 19.5

                if rating > 4
                    posleft = 45 + 25.2
                else if rating > 3
                    posleft = 45 + 12.3
                else if rating > 2
                    posleft = 45
                else if rating > 1
                    posleft = 45 - 13

                clearTimeout(rating_tool_tip)
                $(this).prev().css({left: posleft + '%' })

                rating_tool_tip = setTimeout ->
                        dom.counter.fadeOut()
                    , 2000

    initialize = (opts) ->
        st = $.extend({}, defaults, opts)
        catchDom st
        events.initPlugin()
        suscribeEvents()

    init: initialize
)()
ratingWidget.init()


contactForm = (->
    dom = {}
    st = {}
    defaults =
        body : 'body, html'
        form : '.contact-form'
    catchDom = (st) ->
        dom.body = $(st.body)
        dom.form = $(st.form)
        return
    suscribeEvents = ->
        return
    events =
        initValidation: () ->
            dom.form.validate(
                errorElement: 'p'
                errorPlacement: events.errorPlacement
                rules: (
                    email: (
                        required: true
                        email: true
                    )
                    name: (
                        required: true
                    )
                )
            )
        errorPlacement: (error, element) ->
            $(element).parent().parent().addClass('input-field-error')
            $(element).parent().parent().find('.error-box').show()
        submitHandler: () ->
            console.log 'submit'

    initialize = (opts) ->
        st = $.extend({}, defaults, opts)
        catchDom st
        events.initValidation()
        suscribeEvents()

    init: initialize
)()
contactForm.init()

