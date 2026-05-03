/**
 * Styles Task
 */
import gulp from 'gulp';
import plumber from 'gulp-plumber';
import sass from 'gulp-sass';
import autoprefixer from 'gulp-autoprefixer';
import size from 'gulp-size';
import rename from 'gulp-rename';
import paths from './lib/paths';
import pluginOptions from './lib/plugin-options';

/**
 * Compile SCSS files
 */
const compileStyles = () => {
  return gulp.src(paths.styles.src)
    .pipe(plumber(pluginOptions.plumber))
    .pipe(sass(pluginOptions.sass))
    .pipe(autoprefixer(pluginOptions.autoprefixer))
    .pipe(size(pluginOptions.size))
    .pipe(gulp.dest(paths.styles.dest));
};

/**
 * Minify SCSS files
 */
const minifyStyles = () => {
  return gulp.src(paths.styles.src)
    .pipe(plumber(pluginOptions.plumber))
    .pipe(sass(pluginOptions.sassMin))
    .pipe(autoprefixer(pluginOptions.autoprefixer))
    .pipe(size(pluginOptions.size))
    .pipe(rename(pluginOptions.rename))
    .pipe(gulp.dest(paths.styles.dest));
};

/**
 * Watch for changes on SCSS files
 */
const watchStyles = () => {
  return gulp.watch(paths.styles.watch, gulp.parallel(compileStyles, minifyStyles));
};

/**
 * Export
 */
export {
  compileStyles,
  minifyStyles,
  watchStyles
}
