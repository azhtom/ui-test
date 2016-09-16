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
                $(this).prev().find('.counter').text(rating)
                $(this).prev().find('.counter').show()

                posleft = 0

                if rating > 4
                    posleft = 199
                else if rating > 3
                    posleft = 149
                else if rating > 2
                    posleft = 99
                else if rating > 1
                    posleft = 49

                clearTimeout(rating_tool_tip)
                $(this).prev().find('.counter').css({left: posleft + 'px' })

                rating_tool_tip = setTimeout ->
                        dom.counter.fadeOut()
                    , 2500

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
        filebox: '.contact-form #fdrag'
        fileinput: '.contact-form input[type=file]'
        filelist: '.contact-form .upload-box .file-list'
    catchDom = (st) ->
        dom.body = $(st.body)
        dom.form = $(st.form)
        dom.filebox = $(st.filebox)
        dom.fileinput = $(st.fileinput)
        dom.filelist = $(st.filelist)
        return
    suscribeEvents = ->
        dom.form.on 'keyup', 'textarea', events.counterDescription
        dom.filebox.on 'click', events.openFileInput
        dom.filebox.bind 'dragover', events.fileDragHover
        dom.filebox.bind 'dragleave', events.fileDragLeave
        dom.filebox.bind 'drop', events.fileSelectHandler
        dom.fileinput.on 'change', events.fileSelectHandler
        return
    events =
        initValidation: () ->
            dom.form.validate(
                errorElement: 'p'
                errorPlacement: events.errorPlacement
                onfocusout: events.onfocusOut
                rules: (
                    email: (
                        required: true
                        email: true
                    )
                    name: (
                        required: true
                    )
                    subject: (
                        required: true
                    )
                    description: (
                        required: true
                    )
                    team: (
                        required: true
                    )
                )
            )
        onfocusOut: (element) ->
            if this.element(element)
                $(element).parent().parent().removeClass('input-field-error')
                $(element).parent().parent().find('.error-box').fadeOut('fast')
        errorPlacement: (error, element) ->
            $(element).parent().parent().addClass('input-field-error')
            $(element).parent().parent().find('.error-box').fadeIn('slow')
        submitHandler: () ->
            console.log 'submit'
        counterDescription: () ->
            total = (300 - $(this).val().length)
            if total >= 0
                $(this).parent().find('.counter').text("Faltan " + total + " caracteres")
            else
                $(this).val($(this).val().substring(0, 300))
        fileDragHover: (e) ->
            e.stopPropagation()
            e.preventDefault()
            $(this).addClass('dghover')
        fileDragLeave: (e) ->
            e.stopPropagation()
            e.preventDefault()
            $(this).removeClass('dghover')
        fileSelectHandler: (e) ->
            e.stopPropagation()
            e.preventDefault()
            files = e.target.files or (e.originalEvent.dataTransfer and e.originalEvent.dataTransfer.files)

            for file in files
                $('<li/>', {
                    text: file.name
                }).appendTo(dom.filelist)

        openFileInput: () ->
            $(dom.fileinput).click()

    initialize = (opts) ->
        st = $.extend({}, defaults, opts)
        catchDom st
        events.initValidation()
        suscribeEvents()

    init: initialize
)()
contactForm.init()

