window.z ?= {}
z.db_api ?= {}

class z.db_api.TextRecognition
  constructor: ->
    @logger = new z.util.Logger 'z.db_api.dbAPIService', z.config.LOGGER.OPTIONS

  categorize: (text) =>
    $.ajax
      contentType: 'application/json'
      type: 'GET'
      url: "http://uclassify.com/browse/uClassify/Topics/ClassifyText?readkey=ZNpRwB2XLWed&text=" + encodeURIComponent(text) + "&output=json&version=1.01"
    .done (data, textStatus, jqXHR) =>
      console.log('yes', data)
    .fail (jqXHR, textStatus, errorThrown) =>
      console.log('no', errorThrown)
