class @DataUtil
  get: (data_type) ->
    $("body").data(data_type)

this.util.data_util = new DataUtil