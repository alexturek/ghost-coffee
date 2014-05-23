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
            run_tests:
                src: 'lib/compiled.js'
                options:
                    specs: 'lib/specs.js'
        watch:
            scripts:
                files: ['src/*', 'spec/*', 'Gruntfile.coffee', '!.*']
                tasks: ['coffee', 'jasmine']
                options:
                    display: 'short'
                    summary: false
                    debounceDelay: 500
    }

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-jasmine'

    grunt.registerTask 'default', ['coffee', 'jasmine']