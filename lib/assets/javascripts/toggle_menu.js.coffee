class @ToggleMenu
  hide_all: () ->
    $show_menu = $(".show_menu")
    $show_menu.removeClass "show_menu"
    $show_menu.trigger "on_toggle_hide"

$(document).ready () ->
  $document = $(this)
  $html = $("html")
  $html.click (event) ->
    $target = $(event.target)
    if $target.closest(".toggle_menu_content").length == 0 and not $target.closest('a').hasClass "toggle_button"
      ToggleMenu::hide_all()
    return

  $document.delegate ".toggle_button", "click", (event) ->
    $toggle_menu = $(this).closest(".toggle_menu")
    if !$toggle_menu.hasClass "show_menu"
      show = true
    ToggleMenu::hide_all()

    if show
      $toggle_menu.addClass "show_menu"
      $toggle_menu.trigger "on_toggle_show"
    event.stopPropagation()
    return false

  $document.delegate ".toggle_menu_content a", "click", (event) ->
    ToggleMenu::hide_all()
    return

$(document).delegate ".toggle_menu", "on_toggle_show", () ->
  $toggle_menu = $(this)
  $toggle_menu_content = $toggle_menu.find(".toggle_menu_content")
  toggle_type = $toggle_menu.data("toggle-type")
  if toggle_type == "scroll_down"
    UIUtil::show($toggle_menu_content, {transition: "vertical"})
  else if toggle_type == "custom"
    # Do Nothing
  else
    $toggle_menu_content.show()

$(document).delegate ".toggle_menu", "on_toggle_hide", () ->
  $toggle_menu = $(this)
  $toggle_menu_content = $toggle_menu.find(".toggle_menu_content")
  toggle_type = $toggle_menu.data("toggle-type")
  if toggle_type == "scroll_down"
    UIUtil::hide($toggle_menu_content, {transition: "vertical"})
  else if toggle_type == "custom"
    # Do Nothing
  else
    $toggle_menu_content.hide()

this.util.toggle_menu = new ToggleMenu