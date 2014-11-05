module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'
    name: "{%= name %}"

    sass:
      styles:
        options:
          bundleExec: true
          style: 'expanded'
          sourcemap: 'none'
        files:
          'styles/<%= name %>.css': 'styles/<%= name %>.scss'

    coffee:
      src:
        options:
          bare: true
        files:
          'lib/<%= name %>.js': 'src/<%= name %>.coffee'
      spec:
        files:
          'spec/<%= name %>-spec.js': 'spec/<%= name %>-spec.coffee'

    umd:
      all:
        src: 'lib/<%= name %>.js'
        template: 'umd.hbs'
        amdModuleId: '<%= pkg.name %>'
        objectToExport: '<%= name %>'
        globalAlias: '<%= name %>'
        deps:
          'default': ['$', 'SimpleModule']
          amd: ['jquery', 'simple-module']
          cjs: ['jquery', 'simple-module']
          global:
            items: ['jQuery', 'SimpleModule']
            prefix: ''

    watch:
      styles:
        files: ['styles/*.scss']
        tasks: ['sass']
      spec:
        files: ['spec/**/*.coffee']
        tasks: ['coffee:spec']
      src:
        files: ['src/**/*.coffee']
        tasks: ['coffee:src', 'umd']
      jasmine:
        files: ['lib/**/*.js', 'specs/**/*.js']
        tasks: 'jasmine:test:build'

    jasmine:
      test:
        src: ['lib/**/*.js']
        options:
          outfile: 'spec/index.html'
          styles: 'styles/<%= name %>.css'
          specs: 'spec/<%= name %>-spec.js'
          vendor: [
            'vendor/bower/jquery/dist/jquery.min.js'
            'vendor/bower/simple-module/lib/module.js'
          ]

  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-umd'

  grunt.registerTask 'default', ['sass', 'coffee', 'umd', 'jasmine:test:build', 'watch']



