/**
 * Build Task
 */
import gulp from 'gulp';
import { compileStyles, minifyStyles } from './styles';
import { compileScripts, copyScripts, minifyScripts } from './scripts';
import { compileMarkup } from './markup';
import { compressImages } from './images';
import { makeIconSprite, copyIcons } from './icons';
import { makeFavicons } from './favicons';
import { copyFonts } from './fonts';
import { copyFiles } from './files';
import cleanDestDir from './clean';

/**
 * Build everything.
 * Compile and minify styles and scripts, compress images, make icon sprite,
 * make favicons, copy fonts and files, etc.
 */
const build = gulp.series(
  cleanDestDir,
  gulp.parallel(
    compileStyles,
    minifyStyles,
    compileScripts,
    copyScripts,
    minifyScripts,
    compileMarkup,
    compressImages,
    makeIconSprite,
    copyIcons,
    makeFavicons,
    copyFonts,
    copyFiles
  )
);

/**
 * Export
 */
export default build
