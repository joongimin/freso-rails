draw_pane = ($canvas, args = {}) ->
  tilt = 320
  canvas = $canvas[0]
  ctx = canvas.getContext("2d")

  screen_width = $("#top_container").width()
  screen_height = $("#top_container").height()

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
  ctx.shadowColor = 'rgba(0, 0, 0, 0.5)';
  ctx.shadowBlur = 5;

  if args.left
    ctx.shadowOffsetX = 1;
    ctx.shadowOffsetY = 1;
  else
    ctx.shadowOffsetX = -1;
    ctx.shadowOffsetY = -1;

  ctx.fill()

$ ->
  $("a#link_login_with_nuvo").click ->
    speed = 1000
    easing = "easeInCubic"

    $iframe_container = $("div.iframe_container")
    $login_with_nuvo = $iframe_container.find("iframe#login_with_nuvo")
    if !$login_with_nuvo.attr("src")
      $login_with_nuvo.attr("src", "http://naver.com")

    $logo_container = $("div.logo_container")
    offset = $logo_container.offset()
    $background_container = $("div.background_container")
    $background_container.find("div.solid").animate({opacity: 0}, 80, "linear", -> $(this).hide())
    $background_container.find("div.split").show().animate({opacity: 1}, 80, "linear")
    $logo_container.
      css("top", offset.top + "px").
      css("left", offset.left + "px").
      css("margin", "0").
      animate({top: offset.top - 10, left: offset.left + 10}, 80, "linear", ->
        $iframe_container.show()
        $logo_container.animate({top: 15, left: 0}, speed, easing)

        $background_container.addClass("splitted")

        $left = $background_container.find("div.split canvas.left")
        $right = $background_container.find("div.split canvas.right")

        draw_pane($left, {left: true})
        draw_pane($right, {left: false})

        visible_width = 250
        $left.animate({left: visible_width - $left.width()}, speed, easing, -> $("div.back_container").show().animate({opacity: 1}))
        $right.animate({right: visible_width - $right.width()}, speed, easing)
        )

    # $logo_container.animate({top: "12%", left: "6%"}, speed, easing)
    $logo_container.find(".login").animate({opacity: 0}, "fast", -> $(this).hide())

  $("a#link_back").click ->
    speed = 1000
    easing = "easeInCubic"

    $("div.back_container").animate({opacity: 0}, null, null, -> $(this).hide())

    $background_container = $("div.background_container")

    $left = $background_container.find("div.split canvas.left")
    $right = $background_container.find("div.split canvas.right")

    $left.animate({left: 0}, speed, easing, ->
      $logo_container.find(".login").show().animate({opacity: 1})
      $("div.iframe_container").hide()
      $background_container.find("div.solid").show().animate({opacity: 1}, 80, "linear")
      $background_container.find("div.split").animate({opacity: 0}, 80, "linear", -> $(this).hide())
      )

    $right.animate({right: 0}, speed, easing)

    $logo_container = $("div.logo_container")
    org_style = $logo_container.attr("style")
    $logo_container.removeAttr("style")
    target_offset = $logo_container.offset()
    $logo_container.attr("style", org_style)
    $logo_container.animate({top: target_offset.top, left: target_offset.left}, speed, easing, -> $logo_container.removeAttr("style"))