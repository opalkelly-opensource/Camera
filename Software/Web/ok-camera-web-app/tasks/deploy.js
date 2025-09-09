/**
 * Deploy Tasks
 */
import gulp from 'gulp';
import rsync from 'gulp-rsync';
import paths from './lib/paths';
import pluginOptions from './lib/plugin-options';

const exec = require('child_process').exec;

/**
 * Deploy built files to the destination folder
 */
const deploy = () => {
  return gulp.src(paths.destDir)
    .pipe(rsync(pluginOptions.rsync));
};

/**
 * Deploy built files to the local folder
 * @param {object} cb
 */
const deployLocally = (cb) => {
    sync(cb);
}

/**
 * Execute rsync command
 * @param {object} cb
 */
function sync(cb) {
    let rsyncCommand = buildRsyncCommand();
    console.log(rsyncCommand);


    exec(rsyncCommand, function (err, stdout, stderr) {
        console.log(stdout);
        console.log(stderr);
        cb(err);
    });
}

/**
 * Helper function for constructing custom Rsync command
 * @return {string}
 */
function buildRsyncCommand() {
    let options = pluginOptions.rsyncLocal;
    let source = options.source.join(' ');
    let destination = options.destination;
    let excludedFiles = options.exclude;
    let excludePattern = [];

    if (excludedFiles.length > 0) {
        excludedFiles.forEach(function(el) {
            excludePattern.push(" --exclude " + el);
        });
    }

    return "rsync -azpv" + excludePattern.join(' ') + " --delete-after " + source + " " + destination + " -F";
}

/**
 * Export
 */
export {
  deploy,
  deployLocally
}
