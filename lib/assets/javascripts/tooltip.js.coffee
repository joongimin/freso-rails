class @Tooltip
  constructor: ->
    $(document).bind "ajax_util:action:before", ->
      util.ui_util.hide($(".tooltip_container .tooltip"))

      fade = (tooltip_container, fade_in) ->
        $tooltip = $(tooltip_container).find(".tooltip")
        if !$tooltip.hasClass("always_show")
          if fade_in
            util.ui_util.fade_in($tooltip)
          else
            util.ui_util.fade_out($tooltip)

      $(".tooltip_container").hover (-> fade(this, true)), (-> fade(this, false))

this.util.tooltip = new Tooltip