class __Model.Breaks extends Monocle.Model

	@fields "break"

	validate: ->
		unless @break
			"El corte es requerido"
		