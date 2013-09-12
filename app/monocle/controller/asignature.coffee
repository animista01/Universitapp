class AsignatureCtrl extends Monocle.Controller

	events: 
		"tap a[data-action=save]"    : "onSave"

	elements:
		"#txtMateria"          		 : "asignatura"
		"#txtSemestre"		 		 : "semestre"
		"#txtSalon"		 		     : "salon"

	constructor: ->
		super
		__Model.Asignature.bind "create", @bindAsignatureCreate

	bindAsignatureCreate: () =>
		$$('#ulAsignatures').html('')
		Lungo.Data.Sql.select('asignatures', '', newOne)
	
	newOne = (asig) =>
		asignature = {data: asig}
		#Get the last item of an array of objects
		last = asig[asig.length - 1]
		#Get the id of that last item
		idAsig = last.id 
		view = new __View.Asignature model: asignature 
		view.append asignature
		date = moment().format("dddd, MMMM Do, YYYY")
		#Add 3 breaks by default
		for i in [1...4]
			breaks = {break: i, asignature_id: idAsig, date, date}
			Lungo.Data.Sql.insert('breaks', breaks)

		Lungo.Router.back()

	initialize: ->
		do Lungo.Notification.show
		Lungo.Data.Sql.select('asignatures', '',showAsignatures)

	showAsignatures = (results) =>
		asignature = {data: results}
		view = new __View.Asignature model: asignature
		view.append asignature
		do Lungo.Notification.hide

	onSave: ->
		if @asignatura.val() and @semestre.val() and @salon.val()
			do Lungo.Notification.show

			asignature = {name: @asignatura.val(), semester: @semestre.val(), room: @salon.val()}

			Lungo.Data.Sql.insert('asignatures', asignature)

			__Model.Asignature.create
				name     : @asignatura.val()
				semester : @semestre.val()
				room : @salon.val()

			#Clean inputs
			@asignatura.val ""
			@semestre.val ""
			@salon.val ""
			do Lungo.Notification.hide
		else 
			Lungo.Notification.error "Por favor llene todos los campos",
				"Para guardar una nueva asignatura necesitas llenar todos los campos correctamente",
				"remove-circle",
				5

	deleteAsig: (id) ->
		Lungo.Data.Sql.drop('asignatures', {id: id})
		Lungo.Data.Sql.drop('breaks', {asignature_id: id})
		Lungo.Data.Sql.drop('scores', {asignature_id: id})
		Lungo.Data.Sql.select('asignatures', '', updateDelete)

	updateDelete = (asig) =>
		do Lungo.Notification.show
		asignature = {data: asig}
		$$('#ulAsignatures').html('')
		view = new __View.Asignature model: asignature 
		view.append asignature
		do Lungo.Notification.hide

__Controller.Asignature = new AsignatureCtrl "section#sect_anotherAsig"