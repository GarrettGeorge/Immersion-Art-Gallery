export default class ArtPiece
  constructor: (pieceData) ->
    @title = pieceData.title
    @artist = pieceData.artist
    @date = pieceData.date
    @style = pieceData.style
    @genre = pieceData.genre
