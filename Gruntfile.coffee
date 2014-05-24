module.exports = (grunt) ->
    grunt.initConfig {
        pkg: grunt.file.readJSON 'package.json'

        coffee:
            compile_source:
                expand: true
                src: 'src/*.coffee'
                dest: 'lib'
                options:
                    bare: true
                rename: (dest, src) ->
                    new_name = dest + '/' + src.replace /\.coffee$/, '.js'
                    new_name = new_name.replace 'src/', ''
            compile_tests:
                src: 'spec/*.coffee'
                dest: 'lib/specs.js'
                options:
                    bare: true
        jasmine:
            run_tests:
                src: 'lib/*.js'
                options:
                    specs: 'lib/specs.js'
                    template: require 'grunt-template-jasmine-requirejs'
                    templateOptions:
                        requireConfig:
                            baseUrl: 'lib/'
        watch:
            scripts:
                files: ['src/*', 'spec/*', 'Gruntfile.coffee']
                tasks: ['coffee', 'jasmine']
                options:
                    display: 'short'
                    summary: false
                    debounceDelay: 500
    }

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-jasmine'
    grunt.loadNpmTasks 'grunt-template-jasmine-requirejs'

    grunt.registerTask 'default', ['coffee', 'jasmine']