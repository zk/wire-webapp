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

class z.entity.SurveyQuestionMessage extends z.entity.HackathonMessage
  constructor: (event_data) ->
    super()

    @super_type = z.message.SuperType.HACKATHON
    @hackathon_message_type = z.message.HackathonMessageType.SURVEY_QUESTION

    @question = event_data.question
    @question_id = event_data.question_id

    @options = ko.observableArray [{content: 'Yes', action: 'report_banking_data'}, {content: 'No', action: ''}]
    @show_options = ko.observable event_data.show_options or false

    @caption = ko.pureComputed ->
      return ' has a question for you'
