class @DataUtil
  get: (data_type) ->
    $("div#data").data(data_type)

this.util.data_util = new DataUtil