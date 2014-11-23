exports.output = (gameSave) ->
	"""
		=== #{gameSave.name}'s team ===

		#{
			(exports.outputPokemon gameSave, pkmn for pkmn in gameSave.team).join '\n\n'
		}
	"""

exports.outputPokemon = (gameSave, pkmn) ->
	"""
		#{pkmn.name} (#{pkmn.species})#{exports.outputItem pkmn.heldItem}
		Ability: #{pkmn.ability}
		Level: #{pkmn.level}
		Shiny: #{if (pkmn.isShiny ? no) then 'Yes' else 'No'}
		Happiness: #{pkmn.friendship}
		EVs: #{exports.outputStats pkmn.evs}
		Naughty Nature
		IVs: #{exports.outputStats pkmn.ivs}
		#{exports.outputMoves pkmn.moves}
	"""

statNames =
	hp: 'HP'
	atk: 'Atk', def: 'Def'
	spd: 'Spd'
	spAtk: 'SAtk', spDef: 'SDef'

exports.outputItem = (item) ->
	if item? then " @ #{item}" else ''

exports.outputStats = (stats) ->
	((stats[stat] + ' ' + statName) for stat, statName of statNames).join ' / '

exports.outputMoves = (moves) ->
	("- #{move.name}" for move in moves).join '\n'