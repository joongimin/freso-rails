class AuthenticationsController
  create: ->
    $.postMessage("success", $("body").data("referer"))

this.Application.authentications = new AuthenticationsController