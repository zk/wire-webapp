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

class z.entity.HackathonMessage extends z.entity.Message
  constructor: ->
    super()

    @super_type = z.message.SuperType.HACKATHON
    @hackathon_message_type = undefined

  is_financial_information: =>
    @hackathon_message_type is z.message.HackathonMessageType.FINANCIAL_INFORMATION

  is_speech_input: =>
    @hackathon_message_type is z.message.HackathonMessageType.SPEECH_INPUT

  is_survey_answer: =>
    @hackathon_message_type is z.message.HackathonMessageType.SURVEY_ANSWER

  is_survey_question: =>
    @hackathon_message_type is z.message.HackathonMessageType.SURVEY_QUESTION
