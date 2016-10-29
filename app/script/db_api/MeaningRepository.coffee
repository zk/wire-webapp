window.z ?= {}
z.db_api ?= {}

class z.db_api.MeaningRepository
  constructor: (@meaning_service) ->
    @logger = new z.util.Logger 'z.db_api.MeaningRepository', z.config.LOGGER.OPTIONS

  _map_category: (category) ->
    switch category
      when z.db_api.FinancialTransactionCategory.ARTS
        return "🎨 " + z.db_api.FinancialTransactionCategory.ARTS
      when z.db_api.FinancialTransactionCategory.BUSINESS
        return "💼 " + z.db_api.FinancialTransactionCategory.BUSINESS
      when z.db_api.FinancialTransactionCategory.CASH_PAYMENT
        return "💵 " + z.db_api.FinancialTransactionCategory.CASH_PAYMENT
      when z.db_api.FinancialTransactionCategory.COMPUTERS
        return "💻 " + z.db_api.FinancialTransactionCategory.COMPUTERS
      when z.db_api.FinancialTransactionCategory.GAMES
        return "🎲 " + z.db_api.FinancialTransactionCategory.GAMES
      when z.db_api.FinancialTransactionCategory.HEALTH
        return "💊 " + z.db_api.FinancialTransactionCategory.HEALTH
      when z.db_api.FinancialTransactionCategory.HOME
        return "🏡 " + z.db_api.FinancialTransactionCategory.HOME
      when z.db_api.FinancialTransactionCategory.RECREATION
        return "🏕 " + z.db_api.FinancialTransactionCategory.RECREATION
      when z.db_api.FinancialTransactionCategory.SCIENCE
        return "🔬 " + z.db_api.FinancialTransactionCategory.SCIENCE
      when z.db_api.FinancialTransactionCategory.SOCIETY
        return "😃 Entertainment"
      when z.db_api.FinancialTransactionCategory.SPORTS
        return "⚽ " + z.db_api.FinancialTransactionCategory.SPORTS
      else
        return category

  update_category: (transaction) ->
    return new Promise (resolve) =>
      text = transaction.counter_party_name + ' ' + transaction.usage
      @meaning_service.recognize text
      .then (recognition) =>
        if transaction.usage?.includes 'Barauszahlung'
          recognition = z.db_api.FinancialTransactionCategory.CASH_PAYMENT
        recognition = @_map_category recognition
        @logger.log "Category '#{transaction.category}' becomes '#{recognition}'"
        transaction.category = recognition
        resolve transaction

  update_categories: (transactions) ->
    promises = []

    for transaction in transactions
      promises.push @update_category transaction

    return Promise.all promises
