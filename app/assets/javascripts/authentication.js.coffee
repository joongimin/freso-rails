class AuthenticationsController
  create: ->
    $.postMessage("success", $("body").data("referer"))

this.freso.authentications = new AuthenticationsController