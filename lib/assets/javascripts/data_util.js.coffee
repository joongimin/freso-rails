class @DataUtil
  get: (data_type) ->
    $("body").data(data_type)

  get_resource_id: ($tag) ->
    id = $tag.attr("id")
    id.slice(id.lastIndexOf("_") + 1)

this.util.data_util = new DataUtil