fs = require 'fs'

pokesavGba = require 'pokesav-gba'
argv = require 'yargs'
	.argv

formatter = require './formatter'

[savefile] = argv._

save = new pokesavGba.Savefile fs.readFileSync savefile

console.log formatter.output save.current