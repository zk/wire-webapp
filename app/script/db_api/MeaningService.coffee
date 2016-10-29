window.z ?= {}
z.db_api ?= {}

class z.db_api.MeaningService
  constructor: ->
    @logger = new z.util.Logger 'z.db_api.MeaningService', z.config.LOGGER.OPTIONS

  recognize: (text) =>
    return new Promise (resolve, reject) =>
      $.ajax
        contentType: 'application/json'
        type: 'GET'
        url: "https://damp-bastion-14619.herokuapp.com/recognize/" + encodeURIComponent(text)
      .done (data, textStatus, jqXHR) =>
        resolve data
      .fail (jqXHR, textStatus, errorThrown) =>
        resolve z.db_api.FinancialTransactionCategory.HOME
