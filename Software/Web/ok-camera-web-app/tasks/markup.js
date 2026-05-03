/**
 * Markup Task
 */
import gulp from 'gulp';
import newer from 'gulp-newer';
import plumber from 'gulp-plumber';
import pug from 'gulp-pug';
import paths from './lib/paths';
import pluginOptions from './lib/plugin-options';

/**
 * Compile markup
 */
const compileMarkup = () => {
  return gulp.src(paths.markup.src)
    .pipe(newer(paths.markup.dest))
    .pipe(plumber(pluginOptions.plumber))
    .pipe(pug(pluginOptions.pug))
    .pipe(gulp.dest(paths.markup.dest));
};

/**
 * Watch changes on markup files
 */
const watchMarkup = () => {
  return gulp.watch(paths.markup.watch, compileMarkup);
};

/**
 * Export
 */
export {
  compileMarkup,
  watchMarkup
}
