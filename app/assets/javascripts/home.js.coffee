class HomeController
  draw_pane = ($canvas, args = {}) ->
    tilt = 400
    canvas = $canvas[0]
    ctx = canvas.getContext("2d")

    screen_width = $("div#home").width()
    screen_height = $("div#home").height()

    canvas.height = screen_height
    if args.left
      $canvas.css("left", 0)
      canvas.width = (screen_width + tilt + 10) * 0.5 + 150
    else
      $canvas.css("right", 0)
      canvas.width = (screen_width + tilt + 10) * 0.5 - 150

    ctx.clearRect(0, 0, canvas.width, canvas.height)
    ctx.fillStyle = "rgb(244, 244, 244)";
    ctx.beginPath()
    if args.left
      ctx.moveTo(0, 0)
      ctx.lineTo(canvas.width - 5, 0)
      ctx.lineTo(canvas.width - tilt, canvas.height)
      ctx.lineTo(0, canvas.height)
    else
      ctx.moveTo(tilt, 0)
      ctx.lineTo(canvas.width, 0)
      ctx.lineTo(canvas.width, canvas.height)
      ctx.lineTo(5, canvas.height)

    ctx.closePath()
    ctx.shadowColor = 'rgba(0, 0, 0, 0.3)';
    ctx.shadowBlur = 13;

    if args.left
      ctx.shadowOffsetX = 1;
      ctx.shadowOffsetY = 1;
    else
      ctx.shadowOffsetX = -1;
      ctx.shadowOffsetY = -1;

    ctx.fill()

  on_resize = ->
    screen_height = $(window).height()
    if screen_height < 700
      screen_height = 700

    $("div#home").height(screen_height)

  login_with_nuvo = ($link) ->
    if $("iframe#login_with_nuvo").length == 0
      $login_with_nuvo = $("<iframe id='login_with_nuvo' height='100%'></iframe>").attr("src", $("div#home_data").data("login-url"))
      $login_with_nuvo.prependTo($("#home"))
      $login_with_nuvo.hide()

  close_login_with_nuvo = ->
    speed = 1000
    easing = "easeInCubic"

    $("div.back_container").animate({opacity: 0}, null, null, -> $(this).hide())

    $background_container = $("div.background_container")

    $left = $background_container.find("div.split canvas.left")
    $right = $background_container.find("div.split canvas.right")

    $left.animate {left: 0}, speed, easing, ->
      $logo_container.find(".login").show().animate({opacity: 1})
      $("iframe#login_with_nuvo").remove()
      $background_container.find("div.solid").show().animate({opacity: 1}, 80, "linear")
      $background_container.find("div.split").animate({opacity: 0}, 80, "linear", -> $(this).hide())
      $("ul#nav").show().animate({opacity: 1}, 400, "linear")

      # Show all parallax scrolls
      $("div.parallax").show()

    $right.animate({right: 0}, speed, easing)

    $logo_container = $("div.logo_container")
    org_style = $logo_container.attr("style")
    $logo_container.removeAttr("style")
    target_offset = $logo_container.offset()
    $logo_container.attr("style", org_style)
    $logo_container.animate({top: target_offset.top, left: target_offset.left}, speed, easing, -> $logo_container.removeAttr("style"))

  display_tooltip: ->
    $(".tooltip_container").closest("ul").find('.tooltip').attr("style", "display: none")

    if @current_menu == 0
      $(".tooltip_container").closest("ul").find(".home_button").attr("style", "opacity: 0")
      $(".tooltip_container").closest("ul").find(".intro").closest('.tooltip').attr("style", "display: block; position: absolute")
    else
      $(".tooltip_container").closest("ul").find(".home_button").attr("style", "opacity: 1")
      $(".tooltip_container").closest("ul").find('.'+ @menu[@current_menu]).closest('.tooltip').attr("style", "display: block; position: absolute")

  index: ->
    $nav = $('#nav').localScroll(800)
    $slider = $("ul#body_slider")
    if $slider.hasClass("sliding")
      $nav.hide()
      $slider.on "nv:slide:end", ->
        $nav.fadeIn()

    screen_height = $(window).height()
    $("div.parallax").each ->
      $this = $(this)
      $this.parallax("50%", $this.data("parallax-speed"))

    $(window).resize on_resize
    on_resize()

    options = {
      autoPlay: false,
      nextButton: true,
      prevButton: true,
      navigationSkip: true,
      fadeFrameWhenSkipped: false,
      cycle: false,
    }
    $("#intro_sequence").sequence(options)
    $("#strength_sequence").sequence(options)

    $("a#link_login_with_nuvo").click ->
      $this = $(this)
      AjaxUtil::push($this.data("title"), $this.data("url"))
      login_with_nuvo($this)

    $("a#link_back").click ->
      $this = $(this)
      AjaxUtil::push $this.data("title"), $this.data("url")
      close_login_with_nuvo()

    @menu = ['home', 'intro', 'strength', 'business_model', 'donation']
    @current_menu = 0
    mousewheel_enable = true
    $('#home-index').mousewheel (event, delta, deltaX, deltaY) =>
      if deltaY != 0 && mousewheel_enable
        mousewheel_enable = false
        $(document).unbind('scroll')
        $('body').addClass('stop-scrolling')
        if deltaY < 0 && @current_menu < 4
          @current_menu++
          $.scrollTo "#"+@menu[@current_menu], 1000, {easing:'easeInOutExpo', onAfter: ->
              mousewheel_enable = true
              $(document).bind('scroll')
            }
        else if deltaY > 0 && @current_menu > 0
          @current_menu--
          $.scrollTo "#"+@menu[@current_menu], 1000, {easing:'easeInOutExpo', onAfter: ->
              mousewheel_enable = true
              $(document).bind('scroll')
            }
        else
          mousewheel_enable = true
        @display_tooltip()

    $("a.icons-sub-nav-button").click ->
      if $(this).data("id") == "intro"
        sequence = $("#intro_sequence").data("sequence")
      else if $(this).data("id") == "strength"
        sequence = $("#strength_sequence").data("sequence")
      $(this).closest("ul").find(".current_page").removeClass("current_page")
      sequence.goTo($(this).data("index") + 1)
      $(this).addClass("current_page")

    $("a.icons-sub-nav-forward-button").click ->
      if $(this).data("id") == "intro"
        sequence = $("#intro_sequence").data("sequence")
      else if $(this).data("id") == "strength"
        sequence = $("#strength_sequence").data("sequence")
      if sequence.currentFrameID < sequence.numberOfFrames
        $(this).closest("ul").find(".current_page").removeClass("current_page")
        $(this).closest("ul").find(".icons-sub-nav-button").each (i) ->
          if i == sequence.currentFrameID
            $(this).addClass("current_page")
        sequence.goTo(sequence.currentFrameID + 1)

    $("a.icons-sub-nav-back-button").click ->
      if $(this).data("id") == "intro"
        sequence = $("#intro_sequence").data("sequence")
      else if $(this).data("id") == "strength"
        sequence = $("#strength_sequence").data("sequence")
      if sequence.currentFrameID != 1
        $(this).closest("ul").find(".current_page").removeClass("current_page")
        $(this).closest("ul").find(".icons-sub-nav-button").each (i) ->
          if i == sequence.currentFrameID - 2
            $(this).addClass("current_page")
        sequence.goTo(sequence.currentFrameID - 1)

    if window.location.href.indexOf("login") != -1
      login_with_nuvo()

    $(window).on "ajax_util:state_changed", (e, path) ->
      if path == ""
        close_login_with_nuvo()
      else if path == "/login"
        login_with_nuvo()

    $.receiveMessage (e) ->
      if e.data == "login_required"
        speed = 1000
        easing = "easeInCubic"

        # Scroll to top
        $("html, body").animate {scrollTop: 0}, "fast", "linear", ->
          # Hide all parallax scrolls
          $("div.parallax").each ->
            if $(this).attr("id") != "home"
              $(this).hide()

        $logo_container = $("div.logo_container")
        offset = $logo_container.offset()
        $background_container = $("div.background_container")
        $background_container.find("div.solid").animate({opacity: 0}, 80, "linear", -> $(this).hide())
        $background_container.find("div.split").show().animate({opacity: 1}, 80, "linear")

        $("ul#nav").animate({opacity: 0}, 400, "linear", -> $(this).hide())

        $logo_container
          .css("top", offset.top + "px")
          .css("left", offset.left + "px")
          .css("margin", "0")
          .animate {top: offset.top - 10, left: offset.left + 10}, 80, "linear", ->
            $("iframe#login_with_nuvo").show()
            $logo_container.animate({top: 15, left: 0}, speed, easing)

            $left = $background_container.find("div.split canvas.left")
            $right = $background_container.find("div.split canvas.right")

            draw_pane($left, {left: true})
            draw_pane($right, {left: false})

            visible_width = 250
            $left.animate({left: visible_width - $left.width()}, speed, easing, -> $("div.back_container").show().animate({opacity: 1}))
            $right.animate({right: visible_width - $right.width()}, speed, easing)

        $logo_container.find(".login").animate({opacity: 0}, "fast", -> $(this).hide())
      else if e.data == "relogin"
        $("iframe#relogin").attr("src", $("div#home_data").data("login-url"))
      else if e.data == "success"
        $.getScript DataUtil::get("root-url")

    $(window).resize =>
      frame_height = $(window).height()
      if frame_height < 700
        frame_height = 700
      $("div.parallax").height(frame_height)
      $.scrollTo( "#"+@menu[@current_menu], 0, {easing:'easeInOutExpo'})
      $(".right_end_bg").attr("style", "border-top-width: " + frame_height + "px")
      $(".left_end_bg").attr("style", "border-bottom-width: " + frame_height + "px")

    $(document).ready ->
      window_height = $(window).height()
      $("div.parallax").height(window_height)
      $(".tooltip_container").closest("ul").find(".home_button").attr("style", "opacity: 0")
      $(".tooltip_container").closest("ul").find(".intro").closest('.tooltip').attr("style", "display: block; position: absolute")
      $(".right_end_bg").attr("style", "border-top-width: " + $(window).height() + "px")
      $(".left_end_bg").attr("style", "border-bottom-width: " + $(window).height() + "px")

    $(".scroll_button").click (e) =>
      @current_menu = @menu.indexOf($(e.target).data("id"))
      @display_tooltip()

    $(".home_button").click =>
      @current_menu = 0
      @display_tooltip()

this.Application.home = new HomeController