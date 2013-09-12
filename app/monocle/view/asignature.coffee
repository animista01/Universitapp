class __View.Asignature extends Monocle.View

	container: "section#main article#art_main ul#ulAsignatures"

	template: """
			{{#data}}
				<li>
		            <div class="right" id="{{id}}">
		            	<a href="#">
		            		<span class="icon trash red"></span>
		            	</a>
		            </div>
		            <a data-action="aAsig" id="{{id}}">
						<div class="left">
			            	<p>Salon {{room}}</p>
			            </div>
			            <br/>
						<small>{{semester}} semestre</small>
						<strong>{{name}}</strong>
					</a>
				</li>
			{{/data}}
		"""	

	events:
		"tap article#art_main ul li [data-action=aAsig]" : "onTap"
		"tap article#art_main ul li div.right"           : "onDelete"

	onTap: (e) -> 
		id = e.currentTarget.id
		do __Controller.Break.getBreaks id

	onDelete: (e) -> 
		id = e.currentTarget.id
		do __Controller.Asignature.deleteAsig id