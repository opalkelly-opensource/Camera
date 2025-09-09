/**
 * Watch Tasks
 */
import gulp from 'gulp';
import { watchStyles } from './styles';
import { watchScripts } from './scripts';
import { watchMarkup } from './markup';
import { watchImages } from './images';
import { watchIcons } from './icons';
import { watchFavicons } from './favicons';
import { watchFonts } from './fonts';
import { watchFiles } from './files';

/**
 * Watch files
 */
const watch = gulp.parallel(
  watchStyles,
  watchScripts,
  watchMarkup,
  watchImages,
  watchIcons,
  watchFavicons,
  watchFonts,
  watchFiles
);

/**
 * Export
 */
export default watch
