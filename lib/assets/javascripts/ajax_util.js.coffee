class @AjaxUtil
  constructor: ->
    $.ajaxSetup({ cache: true })
    $body = $("body")
    AjaxUtil::action($body.data("controller").replace(/\//g, "_"), $body.data("action"))

    History = window.History
    if !History.enabled
      return false

    History.Adapter.bind window, 'statechange', ->
      AjaxUtil::on_statechange()
    AjaxUtil::current_state = 0
    AjaxUtil::root_url = DataUtil::get("root-url")
    AjaxUtil::title_prefix = DataUtil::get("title-prefix")

  push: (title, url) ->
    History.pushState({state: ++AjaxUtil::current_state}, AjaxUtil::title_prefix + title, url)

  on_statechange: ->
    State = History.getState()
    console.log("next state = ", State.data.state, "current state = ", AjaxUtil::current_state, State.url)
    if (State.data.state || 0) != AjaxUtil::current_state
      if State.data.state > AjaxUtil::current_state
        next_url = State.url + "?history=forward"
      else if State.data.state < AjaxUtil::current_state
        next_url = State.url + "?history=back"

      if State.data.state != 2 && AjaxUtil::current_state == 1
        AjaxUtil::current_state = 0
        next_url = State.url + "?history=back"
      else
        AjaxUtil::current_state = State.data.state
      $.ajax({type: "GET", url: next_url, dataType: "script"})
      $(window).trigger("ajax_util:state_changed", State.url.replace(AjaxUtil::root_url, ""))

  action: (controller, action) ->
    $(document).trigger("ajax_util:action:before")
    active_controller = util[controller + "_controller"]
    if active_controller
      if $.isFunction(active_controller.init)
        active_controller.init()

      if $.isFunction(active_controller[action])
        active_controller[action]()

    $("body").attr("data-controller", controller).attr("data-action", action)

$ ->
  util.ajax_util = new AjaxUtil