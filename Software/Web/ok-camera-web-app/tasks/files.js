/**
 * Files Task
 */
import gulp from 'gulp';
import newer from 'gulp-newer';
import plumber from 'gulp-plumber';
import paths from './lib/paths';
import pluginOptions from './lib/plugin-options';

const gulpOptions = {
  allowEmpty: true
}

/**
 * Copy files to the destination folder
 */
const copyFiles = () => {
  return gulp.src(paths.files.src, gulpOptions)
    .pipe(newer(paths.files.dest))
    .pipe(plumber(pluginOptions.plumber))
    .pipe(gulp.dest(paths.files.dest));
};

/**
 * Watch changes on files
 */
const watchFiles = () => {
  return gulp.watch(paths.files.src, copyFiles);
};

/**
 * Export
 */
export {
  copyFiles,
  watchFiles
}
