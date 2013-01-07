//= require jquery
//= require ../external_lib/jquery/jquery.ba-postmessage
$ ->
  $.postMessage("success", $("div#data").data("referer"))