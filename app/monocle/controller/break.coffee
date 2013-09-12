class BreakCtrl extends Monocle.Controller

	elements:
		"#txtBreak"                      	  	   : "break"
		"#txtScore"                      	   	   : "score"
		"#art_anotherScore select"				   : "type"
		"#txtPriBreak"                      	   : "primerBreak"
		"#txtSeconBreak"                      	   : "segundoBreak"
		"#txtThiBreak"                      	   : "tercerBreak"

	events: 
		"tap a[data-action=saveBreak]"   	   	   : "onSave"
		"tap a[data-action=saveScore]"         	   : "onSaveScore"
		"tap a[data-action=saveConfigBreak]"   	   : "onSaveBreakConfig"
		"tap a#aLoadRecord"   	                   : "onLoadRecord"

	idAsig = ''
	idBreak = ''
	constructor: ->
		super
		__Model.Breaks.bind "create", @bindBreakCreate
		__Model.Score.bind "create", @bindScoreCreate

	bindBreakCreate: () =>
		Lungo.Data.Sql.select('breaks', {asignature_id: idAsig}, newOne)

	newOne = (datos) =>
		$$('article#art_breaks ul').html('')
		breaks = {data: datos}
		view = new __View.Breaks model: breaks 
		view.append breaks
		Lungo.Router.section('sect_breaks')

	bindScoreCreate: (yay) =>
		#console.log yay

	#get all the breaks by the id of an Asignature
	getBreaks: (id) ->
		do Lungo.Notification.show
		$$('article#art_breaks ul').html('')
		idAsig = id
		Lungo.Data.Sql.select('breaks', {asignature_id: idAsig}, showBreaks)

	showBreaks = (results) =>
		Lungo.Router.article('sect_breaks','art_breaks')
		breaks = {data: results}
		view = new __View.Breaks model: breaks
		view.append breaks
		
		do Lungo.Notification.hide

	onSave: ->
		do Lungo.Notification.show
		if @break.val()
			date = moment().format("dddd, MMMM Do, YYYY")
			theBreak = {break: @break.val(), asignature_id: idAsig, date, date}
			Lungo.Data.Sql.insert('breaks', theBreak)
			__Model.Breaks.create
				break     : @break.val()
			@break.val ''
		else 
			Lungo.Notification.error "Por favor llene el campo",
				"remove-circle",
				3
		do Lungo.Notification.hide

	#Scores
	getViewScore: (idbreak) ->
		idBreak = idbreak
		Lungo.Router.section('sect_newScore')

	onSaveScore: ->
		do Lungo.Notification.show
		type = @type[0].value
		if @score.val()
			date = moment().format("dddd, MMMM Do, YYYY")
			#Lungo.Data.Sql.select('scores', {break: idBreak}, newOne)

			#count_scores
			theScore = {score: @score.val(), type: type, break: idBreak, asignature_id: idAsig, date, date}
			Lungo.Data.Sql.insert('scores', theScore)
			__Model.Score.create
				score     : @score.val()
			@score.val ''
			Lungo.Router.section('sect_breaks')
		else 
			Lungo.Notification.error "Por favor llene el campo",
				"remove-circle",
				3
			#getBreaks(idAsig)
		do Lungo.Notification.hide

	#Config Breaks
	onSaveBreakConfig: ->
		do Lungo.Notification.show
		if @primerBreak.val() and @segundoBreak.val() and @tercerBreak.val()
			configBreak = {firstBreak: @primerBreak.val(), secondBreak: @segundoBreak.val(), thirdBreak: @tercerBreak.val()}
			Lungo.Data.Storage.persistent("configBreaks", configBreak)
			$$('#liBreakConfig').remove()
			Lungo.Router.section('main')
		else 
			Lungo.Notification.error "Por favor llene el campo",
				"remove-circle",
				3
		do Lungo.Notification.hide

	onLoadRecord: ->
		$$('section#sect_record article ul').html('')
		Lungo.Data.Sql.select('scores', {asignature_id: idAsig}, loadRecords)

	loadRecords = (datos) =>
		Lungo.Router.section('sect_record')
		record = {data: datos}
		if Object.keys(datos).length == 0
		else
			view = new __View.Record model: record
			view.append record
		
		do Lungo.Notification.hide

__Controller.Break = new BreakCtrl "section#sect_breaks"
__Controller.Break = new BreakCtrl "section#sect_newBreak"
__Controller.Break = new BreakCtrl "section#sect_newScore"
__Controller.Break = new BreakCtrl "section#sect_config"
__Controller.Break = new BreakCtrl "section#sect_record"