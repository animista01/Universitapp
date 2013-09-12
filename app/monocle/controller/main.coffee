class MainCtrl extends Monocle.Controller
		
	initialize: ->
		CONFIG =
			name:    'universitapp'
			version: '1.0'
			size: 65536
			schema: [
				{
				name: 'asignatures'
				drop: false
				fields:
		    		id:   'INTEGER PRIMARY KEY AUTOINCREMENT'
		    		name: 'STRING'
		    		semester: 'INTEGER'
		    		room: 'TEXT'
    			}
				{
	    		name: 'breaks'
	    		drop: false
	    		fields:
	    			id: 'INTEGER PRIMARY KEY AUTOINCREMENT'
	    			break: 'INTEGER'
	    			asignature_id: 'INTEGER'
	    			date: 'STRING'
    			}
				{
    			name: 'scores'
	    		drop: false
	    		fields:
	    			id: 'INTEGER PRIMARY KEY AUTOINCREMENT'
	    			score: 'INTEGER'
	    			type: 'STRING'
	    			break: 'INTEGER'
	    			asignature_id: 'INTEGER'
	    			date: 'STRING'
    			}
			]
		Lungo.Data.Sql.init(CONFIG)
		do __Controller.Asignature.initialize

	elements:
		"#txtMateria"                      : "asignatura"
		"#txtSemestre"                     : "semestre"

Lungo.ready ->
	configBreak = Lungo.Data.Storage.persistent("configBreaks")
	if configBreak
		$$('#liBreakConfig').remove()
	
	__Controller.Main = new MainCtrl "section#main"
	do __Controller.Main.initialize