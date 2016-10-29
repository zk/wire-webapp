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

class z.db_api.DBAPIService
  URL_ADDRESSES: '/addresses'
  URL_CASHACCOUNTS: '/cashAccounts'
  URL_TRANSACTIONS: '/transactions'
  URL_USERINFO: '/userInfo'

  constructor: ->
    @logger = new z.util.Logger 'z.db_api.DBAPIService', z.config.LOGGER.OPTIONS
    @rest_url = 'https://simulator-api.db.com:443'
    @api_url = '/gw/dbapi/v1'

    @access_token = ko.observable ''
    @access_token_type = ''
    @access_token_expires_in = ko.observable()
    @access_token_promise = undefined

    @access_token.subscribe (access_token) =>
      if access_token and _.isFunction @access_token_promise
        @access_token_promise()

    @access_token_expires_in.subscribe (expires_in) =>
      return if not expires_in
      window.setTimeout =>
        @access_token ''
        @access_token_type = ''
      , expires_in * 1000 - 15000

  _create_url: (url) ->
    return "#{@rest_url}#{@api_url}#{url}"

  _get_access_token: =>
    return Promise.resolve() if @access_token()
    return new Promise (resolve) =>
      window.open "#{@rest_url}/gw/oidc/authorize?response_type=token&redirect_uri=#{@_get_redirect_url()}&&client_id=#{@_get_client_id()}"
      @access_token_promise = resolve

  _get_client_id: ->
    if z.util.Environment.frontend.is_localhost()
      return 'dbd626d7-63db-4684-b9fc-47b688c671bf'
    return '4c11bbf1-1e78-47eb-ae50-6322c78576d0'

  _get_redirect_url: ->
    if z.util.Environment.frontend.is_localhost()
      return 'http://localhost:8888/db_api'
    return 'https://wire-webapp-edge.wire.com/db_api'

  get_addresses: ->
    @_api_request
      url: z.db_api.DBAPIService::URL_ADDRESSES

  get_cash_accounts: (iban) ->
    @_api_request
      url: z.db_api.DBAPIService::URL_CASHACCOUNTS
      data:
        iban: iban if iban

  get_transactions: (iban) ->
    @_api_request
      url: z.db_api.DBAPIService::URL_TRANSACTIONS
      data:
        iban: iban if iban

  get_user_info: ->
    @_api_request
      url: z.db_api.DBAPIService::URL_USERINFO

  _api_request: (config) =>
    @_get_access_token()
    .then =>
      @_execute_api_request config

  _execute_api_request: (config) =>
    return new Promise (resolve, reject) =>
      $.ajax
        contentType: 'application/json; charset=utf-8'
        data: JSON.stringify config.data
        headers:
          Authorization: "#{@access_token_type} #{@access_token()}"
        type: config.type or 'GET'
        url: @_create_url config.url
      .done (data, textStatus, jqXHR) =>
        @logger.log @logger.levels.OFF, "Server Response '#{jqXHR.wire.request_id}' from '#{config.url}':", data
        config.callback? data
        resolve data
      .fail (jqXHR, textStatus, errorThrown) ->
        reject new Error errorThrown
