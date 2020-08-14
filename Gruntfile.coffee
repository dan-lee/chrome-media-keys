module.exports = (grunt) ->
	grunt.initConfig
		copy:
			src:
				files: [
					{expand: true, cwd: 'src/', src: ['**/*.js', '**/*.png', '**/*.css', '**/*.html', '**/*.otf'], dest: 'ext/'}
					{expand: true, cwd: 'handler/', src: ['**'], dest: 'ext/handler/'}
				]
		coffee:
			src:
				files: [
					{expand: true, cwd: 'src/', src: '**/*.coffee', dest: 'ext/', ext: '.js'}
				]
		haml:
			src:
				files: [
					{expand: true, cwd: 'src/', src: '**/*.haml', dest: 'ext', ext: '.html'}
				]
		watch:
			all:
				files: ['src/**', 'handler/**']
				tasks: ['build:manifest', 'coffee:src', 'copy:src', 'haml:src']

	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-haml'

	grunt.registerTask 'build:manifest', 'Build chrome manifest file.', () ->
		mnf = grunt.file.readJSON 'src/manifest.json'
		# Manipulate manifest here if necessary.
		grunt.file.write 'ext/manifest.json', JSON.stringify(mnf)

	grunt.registerTask 'build:sources', ['copy:src', 'coffee:src']
	grunt.registerTask 'build', ['build:manifest', 'build:sources', 'haml:src']
	grunt.registerTask 'run', ['build:manifest', 'build', 'watch']
	grunt.registerTask 'default', ['build']

