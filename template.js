'use strict';

exports.description = "Create an simple module.";
exports.notes = 'The _source_name_ would be the name of all files and classes.';
exports.warnOn = "*";

exports.template = function(grunt, init, done) {

  init.process({}, [
    // Prompt for these values.
    init.prompt('name'),
    init.prompt('source_name', function(value, data, done) {
        done(null, data.name.split("-")[1])
    }),
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

    props.class_name = props.source_name.charAt(0).toUpperCase() + props.source_name.slice(1)

    // Files to copy (and process).
    var files = init.filesToCopy(props);

    // Actually copy (and process) files.
    init.copyAndProcess(files, props);

    // Generate package.json file.
    init.writePackageJSON('package.json', props);

    // All done!
    done();
  });

};
