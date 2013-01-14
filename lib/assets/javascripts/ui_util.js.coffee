class @UIUtil
  slide_content: ($slider, html, args = {}) ->
    args["direction"] ||= "right"

    screen_width = $(window).width()
    screen_height = $(window).height()

    $slider.addClass("sliding")
    $current_slide = $slider.children("li.current_slide").css("float", "left").css("width", screen_width).css("height", screen_height)

    $next_slide = $("<li class='next_slide'></li>")
    $next_slide.css("float", "left").css("width", screen_width).css("height", screen_height).html(html)

    if args["direction"] == "right"
      $slider.append($next_slide)
      target_margin_left = "-100%"
    else
      $slider.prepend($next_slide)
      $slider.css("margin-left": "-100%")
      target_margin_left = 0

    $slider
      .css("width", screen_width * 2)
      .css("height", screen_height)
      .animate {"margin-left": target_margin_left}, {
        easing: "easeInCubic",
        duration: 1000,
        complete: ->
          $current_slide.remove()
          $next_slide.css("float", "").css("width", "").css("height", "").removeClass("next_slide").addClass("current_slide")
          $slider.css("margin-left", "").css("width", "").css("height", "")
          $slider.removeClass("sliding").trigger("nv:slide:end")
      }

  show: ($target, args = {}) ->
    if args.transition == "vertical"
      $target.show()
      if args.height
        natural_height = args.height
      else
        $target.css("height", "auto")
        natural_height = $target.height()

      $target.css("height", 0)
      $target.animate {height: natural_height}, args.transition_speed || 400, ->
        if args.height
          $target.height(args.height)
        else
          $target.css("height", "auto")
    else
      $target.show()

  hide: ($target, args = {}) ->
    if args.transition == "vertical"
      $target.animate {height: 0}, args.transition_speed || 400, ->
        $target.hide()
        if args.callback
          args.callback()
    else
      $target.hide()

this.util.ui_util = new UIUtil