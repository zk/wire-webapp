#
# Wire
# Copyright (C) 2016 Wire Swiss GmbH
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see http://www.gnu.org/licenses/.
#

window.z ?= {}
z.db_api ?= {}

class z.db_api.dbAPIRepository
  constructor: (@db_api_service) ->
    @logger = new z.util.Logger 'z.db_api.dbAPIRepository', z.config.LOGGER.OPTIONS

  get_access_token: =>

  get_addresses: =>
    @db_api_service.get_addresses()
    .then (response) =>
      @logger.log @logger.levels.DEBUG, 'DB API addresses response', response
      return response

  get_cash_accounts: (iban) =>
    @db_api_service.get_cash_accounts iban
    .then (response) =>
      @logger.log @logger.levels.DEBUG, 'DB API cash accounts response', response
      return response

  get_transactions: (iban) =>
    @db_api_service.get_transactions iban
    .then (response) =>
      @logger.log @logger.levels.DEBUG, "DB API transactions response - '#{response.length}'", response
      return response

  get_user_info: =>
    @db_api_service.get_user_info iban
    .then (response) =>
      @logger.log @logger.levels.DEBUG, 'DB API user info response', response
      return response
