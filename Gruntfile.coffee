module.exports = (grunt) ->

	require('load-grunt-tasks')(grunt)

	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'

		
		coffee:
			build:
				expand: yes
				cwd: 'src/'
				src: '**/*.coffee'
				dest: 'lib/'
				ext: '.js'

		coffeelint:
			build:
				files: src: ['src/**/*.coffee', 'test/**/*.coffee']
			options:
				no_tabs: level: 'ignore' # this is tab land, boy
				indentation: value: 1 # single tabs
		

		mochaTest:
			test:
				options:
					reporter: 'spec'
					require: ['coffee-script/register']

				src: ['test/**/*.test.{js,coffee}']

		watch:
			default:
				files: ['src/**/*.{js,coffee}', 'test/**/*.{js,coffee}']
				tasks: ['default']

			dev:
				files: ['src/**/*.{js,coffee}', 'test/**/*.{js,coffee}']
				tasks: ['lint', 'test']

			test:
				files: ['src/**/*.{js,coffee}', 'test/**/*.{js,coffee}']
				tasks: ['test']

			lint:
				files: ['src/**/*.{js,coffee}', 'test/**/*.{js,coffee}']
				tasks: ['lint']

		curl:
			node_bin:
				files:
					'tmp/node.exe': 'http://nodejs.org/dist/latest/node.exe'

		browserify:
			main:
				options:
					browserifyOptions:
						builtins: no
						commondir: no
						detectGlobals: no
						insertGlobalVars: '__filename,__dirname'

				files:
					'tmp/main.js': ['lib/index.js']

		compress:
			dist:
				options:
					archive: '<%= pkg.name %>-<%= pkg.version %>.zip'

				files: [
					{
						expand: true
						cwd: 'tmp'
						src: ['**/*']
						dest: ''
					}
				]

	grunt.registerTask 'download_node_bin', ->
		if not grunt.file.exists 'tmp/node.exe'
			grunt.log.writeln 'Downloading NodeJS binary...'
			grunt.task.run 'curl:node_bin'

		else grunt.log.writeln 'NodeJS binary already downloaded.'

	grunt.registerTask 'write_run_bat', ->
		pkg = grunt.config 'pkg'

		contents = """
			@ECHO off

			"%~dp0/node.exe" "%~dp0/main.js" %* > pkmn.txt 2> %~dp0/err.txt
		"""

		grunt.file.write 'tmp/run.bat', contents, encoding: 'utf-8'

	grunt.registerTask 'default', ['lint','test','build']

	grunt.registerTask 'build', ['coffee:build']

	grunt.registerTask 'dev', ['lint', 'test']

	grunt.registerTask 'lint', ['coffeelint:build']
	grunt.registerTask 'test', ['mochaTest:test']

	grunt.registerTask 'standalone', [
		'default'
		'download_node_bin'
		'browserify:main'
		'write_run_bat'
		'compress:dist'
	]

	grunt.registerTask 'watch-dev', ['watch:dev']