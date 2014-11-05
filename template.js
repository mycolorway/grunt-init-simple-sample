'use strict';

exports.description = "Create an simple module.";
exports.notes = 'The _project name_ will prefix "simple-" automactically.';
exports.warnOn = "*";

exports.template = function(grunt, init, done) {

  init.process({}, [
    // Prompt for these values.
    init.prompt('name'),
    init.prompt('description'),
    init.prompt('version'),
    init.prompt('repository'),
    init.prompt('homepage'),
    init.prompt('bugs'),
    init.prompt('author_name'),
    init.prompt('author_email'),
    init.prompt('author_url'),
  ], function(err, props) {
    props.keywords = [];
    props.devDependencies = {
        "grunt": "0.x",
        "grunt-contrib-watch": "0.x",
        "grunt-contrib-coffee": "0.x",
        "grunt-contrib-sass": "0.x",
        "grunt-contrib-jasmine": "0.x",
        "grunt-umd": "2.x"
    };

    // Files to copy (and process).
    var files = init.filesToCopy(props);

    // Actually copy (and process) files.
    init.copyAndProcess(files, props);

    // Generate package.json file.
    init.writePackageJSON('package.json', props);

    // All done!
    done();
  });
