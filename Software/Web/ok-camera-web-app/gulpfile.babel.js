/**
 * Gulp config file
*/
'use strict';

import gulp from 'gulp';
import { compileStyles, minifyStyles, watchStyles } from './tasks/styles';
import { compileScripts, minifyScripts, watchScripts } from './tasks/scripts';
import { compileMarkup, watchMarkup } from './tasks/markup';
import { compressImages, watchImages } from './tasks/images';
import { makeIconSprite, copyIcons, watchIcons } from './tasks/icons';
import { makeFavicons, watchFavicons, checkForFaviconUpdate } from './tasks/favicons';
import { copyFonts, watchFonts } from './tasks/fonts';
import { copyFiles, watchFiles } from './tasks/files';
import server from './tasks/server';
import build from './tasks/build';
import watch from './tasks/watch';
import clean from './tasks/clean';
import { deploy, deployLocally } from './tasks/deploy';

/**
 * Default task
 */
gulp.task('default', gulp.parallel(server, watch));

/**
 * Export
 */
export {
  compileStyles,
  minifyStyles,
  watchStyles,

  compileScripts,
  minifyScripts,
  watchScripts,

  compileMarkup,
  watchMarkup,

  compressImages,
  watchImages,

  makeIconSprite,
  copyIcons,
  watchIcons,

  makeFavicons,
  watchFavicons,
  checkForFaviconUpdate,

  copyFonts,
  watchFonts,

  copyFiles,
  watchFiles,

  server,
  build,
  watch,
  clean,
  deploy,
  deployLocally
}
