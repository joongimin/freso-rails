class SessionsController
  create: ->
    $.postMessage("success", $("body").data("referer"))

this.freso.sessions_controller = new SessionsController