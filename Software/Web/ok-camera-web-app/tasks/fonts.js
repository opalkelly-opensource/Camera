/**
 * Fonts Task
 */
import gulp from 'gulp';
import paths from './lib/paths';

/**
 * Copy fonts to the destination folder
 */
const copyFonts = () => {
  return gulp
    .src(paths.fonts.src)
    .pipe(gulp.dest(paths.fonts.dest));
};

/**
 * Watch changes on fonts
 */
const watchFonts = () => {
  return gulp.watch(paths.fonts.src, copyFonts);
};

/**
 * Export
 */
export {
  copyFonts,
  watchFonts
}
