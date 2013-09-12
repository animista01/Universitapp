class __View.Breaks extends Monocle.View

	container: "section#sect_breaks article#art_breaks ul"

	template: """
			{{#data}}
				<li class="liId" id="{{break}}">
					<input type="hidden" value="{{asignature_id}}" />
					<strong>Corte # {{break}}</strong>
				</li>
			{{/data}}
		"""	

	events:
		"tap article#art_breaks ul li.liId" : "onTap"

	onTap: (e) -> 
		id = e.currentTarget.id
		do __Controller.Break.getViewScore id