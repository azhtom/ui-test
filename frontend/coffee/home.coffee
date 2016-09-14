# Test
# by @azhtom

$(document).ready ->
    
    rating_tool_tip = null
    
    $("#stars").rateYo({
        halfStar    : true,
        spacing     : "10px",
        normalFill  : "#EAEAEA",
        starWidth   : "40px",
        onChange: (rating, rateYoInstance) ->
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
                        $("#rating .counter").fadeOut()
                    , 2000
    })

    $('.upload-box span').on 'click', () ->
        $('.upload-box input[type=file]').click()
        
    $('.upload-box input[type=file]').change () ->
        filename = $(this).val().replace(/C:\\fakepath\\/i, '')
        $('.upload-box div').text(filename)
