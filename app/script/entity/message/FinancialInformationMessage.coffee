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
z.entity ?= {}

class z.entity.FinancialInformationMessage extends z.entity.Message
  constructor: ->
    super()

    @super_type = z.message.SuperType.HACKATHON
    @hackathon_message_type =

    @iban = ko.observable undefined
    @number_of_transactions = ko.observable undefined

    @caption = ko.pureComputed =>
      if @iban()
        return "#{@number_of_transactions()} transactions made in account #{@iban} were send to Mr. Müller"
      return "#{@number_of_transactions()} transactions were send to Mr. Müller"
