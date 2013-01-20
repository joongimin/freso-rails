class SessionsController
  create: ->
    $.postMessage("logged_in", $("body").data("referer"))

  logged_out: ->
    $.postMessage("logged_out", $("body").data("referer"))

this.freso.sessions_controller = new SessionsController