fs = require 'fs'

pokesavGba = require 'pokesav-gba'
argv = require 'yargs'
	.argv

formatter = require './formatter'

[savefile] = argv._

console.log formatter.output new pokesavGba.GameSave fs.readFileSync savefile