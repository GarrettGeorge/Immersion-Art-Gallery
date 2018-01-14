import ArtPiece from './art.piece.coffee'

export default class ArtCollection
  constructor: (collectionData) ->
    @name = collectionData.name
    @artPieces = collectionData.artPieces.forEach (data, index) ->
      new ArtPiece(data)
