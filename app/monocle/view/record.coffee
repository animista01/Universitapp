class __View.Record extends Monocle.View

	container: "section#sect_record article ul"

	template: """
			{{#data}}
				<li class="liId" id="{{id}}">
					<div class="right">
		            	{{type}}
		            	<a href="#">
		            		<span class="icon edit"></span>
		            	</a>
		            </div>
		            </div>
					<small>Corte # {{break}}</small>
					<input type="hidden" value="{{asignature_id}}" />
					<strong>Nota {{score}}</strong>
				</li>
			{{/data}}
		"""	

	events:
		"tap article#art_breaks ul li.liId" : "onTap"

	onTap: (e) -> 
		id = e.currentTarget.id
		do __Controller.Break.getViewScore id