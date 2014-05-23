module.exports = (grunt) ->
    grunt.initConfig {
        pkg: grunt.file.readJSON 'package.json'
        coffee:
            compile_source:
                src: 'src/*.coffee'
                dest: 'lib/compiled.js'
            compile_tests:
                src: 'spec/*.coffee'
                dest: 'lib/specs.js'
                options:
                    bare: true
        jasmine:
            run_all:
                src: 'lib/compiled.js'
                specs: 'lib/specs.js'

        # not working yet
        watch:
            scripts:
                files: ['**/*.coffee']
                tasks: ['coffee', 'jasmine']
    }

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-jasmine'

    grunt.registerTask 'default', ['coffee', 'jasmine']