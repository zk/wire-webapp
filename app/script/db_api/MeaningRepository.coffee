window.z ?= {}
z.db_api ?= {}

class z.db_api.MeaningRepository
  constructor: (@meaning_service) ->
    @logger = new z.util.Logger 'z.db_api.MeaningRepository', z.config.LOGGER.OPTIONS

  update_category: (transaction) ->
    return new Promise (resolve) =>
      text = transaction.counter_party_name + ' ' + transaction.usage
      @meaning_service.recognize text
      .then (recognition) =>
        @logger.log "Category '#{transaction.category}' becomes '#{recognition}'"
        transaction.category = recognition
        resolve transaction

  update_categories: (transactions) ->
    promises = []

    for transaction in transactions
      promises.push @update_category transaction

    return Promise.all promises
