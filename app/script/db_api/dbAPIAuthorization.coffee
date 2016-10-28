window.z ?= {}
z.db_api ?= {}

class z.db_api.dbAPIAuthorization
  constructor: ->
    @opener_context = window.opener
    return window.location.replace 'https://wire.com' if not @opener_context

    window.wire = @opener_context.wire
    return if not wire

    #access_token=eyJraWQiOiJyc2ExIiwiYWxnIjoiUlMyNTYifQ.eyJhdWQiOiJjYTQxOWEyNS1lYmYyLTRiZDYtOWJlYS02OWUwNjQ0NDMxN2QiLCJpc3MiOiJodHRwczpcL1wvc2ltdWxhdG9yLWFwaS5kYi5jb21cL2d3XC9vaWRjXC8iLCJleHAiOjE0Nzc2OTY2OTMsImlhdCI6MTQ3NzY5MzA5MywianRpIjoiNzExNmU1ZmYtNWI2Yi00NTE4LWI5YTItNzM1N2UyYTk2YjVhIn0.EooOtryT-DNkaZX5KuUtTosbQRCXFhHktNsHFs2gcKJXTu6m6aZQaUwJoLtC6RC6Tx1VNwuh6k077dSoNZBrslrIam_l5ldWYjtDZ5HI542r6zT7xozja_gXJkaB9uh9Sidt4x2IzFdnHUJL5jMl7sUQu8ewwp5KL81mhsTOuS0PWe06dvoE2J-fmeQB6WGD3XHsQL37HsuS62ya4BGqI6QSVueC9KV2P_hHgK8ms3eyqhdFLHTOWohQWDAIupWo3jr2MTDwUeGW9Z53QvUEasCGLXTh87DXoBsD9iAVO9mAqVzzYcchGsu1V53LlPLuWadFOajNtvENbywbnoQLrg&token_type=Bearer&expires_in=3599&id_token=eyJraWQiOiJyc2ExIiwiYWxnIjoiUlM1MTIifQ.eyJhdF9oYXNoIjoiVHNuUlhobFk1SEIyb1N5cTVlSVNKRGZjazZhSUcxNXpuMW5NSDF0ZUpWayIsInN1YiI6IjEwMDAwMDAwMDE4OSIsImF1ZCI6ImNhNDE5YTI1LWViZjItNGJkNi05YmVhLTY5ZTA2NDQ0MzE3ZCIsImtpZCI6InJzYTEiLCJpc3MiOiJodHRwczpcL1wvc2ltdWxhdG9yLWFwaS5kYi5jb21cL2d3XC9vaWRjXC8iLCJleHAiOjE0Nzc2OTM2OTMsImlhdCI6MTQ3NzY5MzA5MywianRpIjoiYzljNTI5OTMtMGQ0MS00MTNkLWFiNTEtOTc3MWUyMjc5MjM2In0.MtVcbDiRGHgW2aKwLZ3Yu46Len99qMIw4P1Ix70wXcnOF5T1PlUzCssavJPpi6XZj8r34agnDmIbdKThY-OJPkxH1vZ1mVI0JtaT1USsiCQt90dOjKMj8GlsdTgcb2UkRAKJVbzlkv_Oez2hUAY4CM-ajOgSwqzU1hj40eh5CGqvztk11zOXpyOh7jeLlwcWa_Sgf_xm1b2QYFTxVtW_9K8UqBVz8ptTs_qNC-RIeEK2wdP__mdFa6QaVPFJROKXxoCGe8OMp2c78bEF-
    hash_parts = window.location.hash.substring(1).split '&'

    @db_api_service = wire.app.repository.db_api.db_api_service
    @db_api_service.access_token if hash_parts[0].startsWith 'access_token' then hash_parts[0].split('=')[1]
    @db_api_service.access_token_type = if hash_parts[1].startsWith 'token_type' then hash_parts[1].split('=')[1]
    @db_api_service.access_token_expires_in if hash_parts[2].startsWith 'expires_in' then hash_parts[2].split('=')[1]

    console.log 'access token', @db_api_service.access_token()
    console.log 'type', @db_api_service.access_token_type
    console.log 'expires', @db_api_service.access_token_expires_in()
    window.close()

  get_url_param: (name) ->
    params = window.location.search.substring(1).split '&'
    for param in params
      value = param.split '='
      return unescape value[1] if value[0] is name
    return null

$ ->
  if $('#wire-db-api').length isnt 0
    wire_db_api = new z.db_api.dbAPIAuthorization()
