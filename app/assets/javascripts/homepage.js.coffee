'use strict'

app = angular.module("soulPlayer", ["ngResource"])

app.factory "Album", ["$resource", ($resource) ->
  $resource("/albums/:id", {id: "@id"}, {update: {method: "PUT"}, destroy: {method: "DELETE"}} )
]

# Declare app level module which depends on filters, and services
# angular.module("soulPlayer", ["soulPlayer.filters", "soulPlayer.controllers", "soulPlayer.services", "soulPlayer.directives"]).config ["$routeProvider", ($routeProvider) ->
#   $routeProvider.when("/albums",
#     templateUrl: "partials/albums.html"
#     controller: "AlbumListCtrl"
#   ).when("/albums/:albumId",
#     templateUrl: "partials/album.html"
#     controller: "AlbumDetailCtrl"
#   ).otherwise redirectTo: "/albums"
# ]

@AlbumCtrl = ["$scope", "Album", ($scope, Album) ->
  $scope.albums = Album.query()
]

# @NowPlayingCtrl = [ "$scope", "audioSource", ($scope, audioSource) ->
# 	$scope.getAlbum()
# ]

@NowPlayingCtrl= ["$scope", "audioSource", ($scope, audioSource) ->
  $scope.getAlbum = ->
    audioSource.getAlbum()

  $scope.getSong = ->
    audioSource.getSong()
]

# angular.module("soulPlayer.controllers", []).controller("AlbumListCtrl", ["$scope", "$http", ($scope, $http) ->
#   $http.get("albums/albums.json").success (data) ->
#     $scope.albums = data

#   $scope.orderProp = "title"
# ]).controller("AlbumDetailCtrl", ["$scope", "$routeParams", "$http", "audioSource", ($scope, $routeParams, $http, audioSource) ->
#   $http.get("albums/" + $routeParams.albumId + ".json").success (data) ->
#     $scope.album = data

#   $scope.play = (album, song) ->
#     audioSource.setSrc
#       album: album
#       song: song

# ]).controller "NowPlayingCtrl", ["$scope", "audioSource", ($scope, audioSource) ->
#   $scope.getAlbum = ->
#     audioSource.getAlbum()

#   $scope.getSong = ->
#     audioSource.getSong()
# ]

angular.module("soulPlayer.directives", []).directive("audioPlayer", ->
  restrict: "E"
  scope:
    song: "="
    album: "="

  templateUrl: "partials/audio-player-directive.html"
  controller: ($scope, $attrs) ->
    $audio = $("audio")[0]
    $scope.currentTime = 0
    $scope.isPlaying = true
    $scope.$watch "isPlaying", ->
      $scope.playSymbol = (if $scope.isPlaying then "❙❙" else "▶")

    $scope.togglePlaying = ->
      (if $scope.isPlaying then $audio.pause() else $audio.play())
      $scope.isPlaying = not $scope.isPlaying
).directive "audioEvents", ->
  restrict: "A"
  scope: true
  link: (scope, elem, attr, ctrl) ->
    $audio = $(elem)[0]
    elem.on "loadedmetadata", ->
      scope.$apply ->
        scope.$parent.currentTime = 0
        scope.$parent.isPlaying = true


    elem.on "ended", ->
      elem.load()

    elem.on "timeupdate", ->
      scope.$apply ->
        scope.$parent.currentTime = Math.floor($audio.currentTime)

angular.module("soulPlayer.filters", []).filter("formatDuration", ->
  (duration) ->
    minutes = Math.floor(duration / 60)
    remainingSeconds = duration % 60
    result = ""
    result = "0"  if remainingSeconds < 10
    result += String(remainingSeconds)
    result = minutes + ":" + result
    result
).filter "totalDuration", ->
  (songs) ->
    durations = _.map(songs, (song) ->
      parseInt song.duration, 10
    )
    result = _.reduce(durations, (total, duration) ->
      total + duration
    , 0)
    result

# angular.module("soulPlayer.services", []).factory "audioSource", ->
app.factory "audioSource", [ ->
  album = undefined
  song = undefined
  
  #factory function body that constructs audioSource instance
  getAlbum: ->
    album

  getSong: ->
    song

  setSrc: (src) ->
    album = src.album
    song = src.song
]

# app.factory "Album", ["$resource", ($resource) ->
#   $resource("/albums/:id", {id: "@id"}, {update: {method: "PUT"}, destroy: {method: "DELETE"}} )
# ]