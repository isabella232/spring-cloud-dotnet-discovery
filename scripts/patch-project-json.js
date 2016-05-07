var jsonfile = require('jsonfile');

// Read in the file to be patched
var file = process.argv[2]; // e.g. '../src/MyProject/project.json'
if (!file)
    console.log("No filename provided");
console.log("File: " + file);

// Read in the build version (this is provided by the CI server)
var version = process.argv[3]; // e.g. '1.0.0-master-10'
var tag = process.argv[4]; // e.g. '', or '1.0.0-rc1'

if (!version) {
    console.log("No version provided");
    return;
}

var lastDash = version.lastIndexOf("-");
var dependsVersion = version.substring(0, lastDash) + '-*';
    
if (tag) {
    // Turn version into tag + '-' + buildnumber
    var buildNumber = version.substring(lastDash + 1, version.length);
    version = tag + '-' + buildNumber;
}
    

jsonfile.readFile(file, function (err, project) {
    
    console.log("Version: " + version);
    console.log("Dependency Version: " + dependsVersion);
    
    // Patch the project.version 
    project.version = version;

    // Patch dependencies
    project['SteelToe.Extensions.Configuration.CloudFoundry'] = dependsVersion;
    project['SteelToe.Extensions.Configuration.ConfigServer'] = dependsVersion;    

    jsonfile.writeFile(file, project, {spaces: 2}, function(err) {
        if (err)
            console.error(err);
    });
})
