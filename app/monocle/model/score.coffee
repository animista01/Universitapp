class __Model.Score extends Monocle.Model

	@fields "score"

	validate: ->
		unless @score
			"La calificacion es requerida"
		