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

class z.db_api.FinancialTransaction
  constructor: (transaction_data) ->
    @amount = transaction_data.amount
    @counter_party_name = transaction_data.counterPartyName
    @counter_party_iban = transaction_data.counterPartyIban
    @usage = transaction_data.usage
    @date = transaction_data.date

    @id = z.util.murmurhash3(JSON.stringify(@to_json()), 'db_api') + ''

  to_json: ->
    return {
      amount: @amount
      counter_party_name: @counter_party_name
      counter_party_iban: @counter_party_iban
      usage: @usage
      date: @date
    }
