window.onerror = (message, url, linenumber) ->
  $.post("/javascript_exception", {message: message, url: url, linenumber: linenumber})