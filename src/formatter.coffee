exports.output = (gameSave) ->
	"""
		=== #{gameSave.name}'s team ===

		#{(pokemon gameSave, pkmn for pkmn in gameSave.team).join '\n\n'}
	"""

exports.pokemon = pokemon = (gameSave, pkmn) ->
	"""
		#{pkmn.name} (#{pkmn.species})#{gender pkmn}#{item pkmn.heldItem}
		Ability: #{pkmn.ability}
		Level: #{pkmn.level}
		Shiny: #{if (pkmn.isShiny ? no) then 'Yes' else 'No'}
		Happiness: #{pkmn.friendship}
		EVs: #{stats pkmn.evs}
		#{nature pkmn} Nature
		IVs: #{stats pkmn.ivs}
		#{moves pkmn.moves}
	"""

statNames =
	hp: 'HP'
	atk: 'Atk', def: 'Def'
	spd: 'Spd'
	spAtk: 'SAtk', spDef: 'SDef'

exports.item = item = (item) ->
	if item? then " @ #{item}" else ''

exports.stats = stats = (stats) ->
	((stats[stat] + ' ' + statName) for stat, statName of statNames).join ' / '

exports.moves = moves = (moves) ->
	("- #{move.name}" for move in moves).join '\n'

exports.gender = gender = (pkmn) ->
	if pkmn.gender? then " (#{if pkmn.gender is 'female' then 'F' else 'M'})"
	else ''

exports.nature = nature = (pkmn) ->
	titleize = (s) -> s[0].toUpperCase() + s[1..]

	if pkmn.nature? then titleize pkmn.nature else 'Naughty'