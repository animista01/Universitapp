class __Model.Asignature extends Monocle.Model

	@fields "name", "semester", "room"

	validate: ->
		unless @name
			"Nombre de la materia es requerido"