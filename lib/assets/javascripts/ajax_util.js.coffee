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
    if (State.data.state || 0) != AjaxUtil::current_state
      AjaxUtil::current_state = State.data.state
      $(window).trigger("ajax_util:state_changed", State.url.replace(AjaxUtil::root_url, ""))

  action: (controller, action) ->
    $(window).trigger("ajax_util:action:started")
    active_controller = util[controller + "_controller"]
    if active_controller
      if $.isFunction(active_controller.init)
        active_controller.init()

      if $.isFunction(active_controller[action])
        active_controller[action]()
    $("body").attr("data-controller", controller).attr("data-action", action)
    $(window).trigger("ajax_util:action:finished")

$ ->
  util.ajax_util = new AjaxUtil