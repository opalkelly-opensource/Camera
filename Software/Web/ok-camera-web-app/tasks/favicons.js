/**
 * Make favicons
 * Based on https://realfavicongenerator.net/
 */
import gulp from 'gulp';
import realFavicon from 'gulp-real-favicon';
import paths from './lib/paths';
import pluginOptions from './lib/plugin-options';
import fs from 'fs';

/**
 * Generate favicons
 */
const makeFavicons = (done) => {
  return realFavicon.generateFavicon(pluginOptions.favicons, () => {
    done();
  });
};

/**
 * Watch changes on favicons
 */
const watchFavicons = () => {
  return gulp.watch(paths.favicons.src, makeFavicons);
};

/**
 * Check for updates on RealFaviconGenerator (think: Apple has just
 * released a new Touch icon along with the latest version of iOS).
 * Run this task from time to time. Ideally, make it part of your
 * continuous integration system.
 */
const checkForFaviconUpdate = () => {
  let currentVersion = JSON.parse(fs.readFileSync(paths.favicons.dataFile)).version;

  return realFavicon.checkForUpdates(currentVersion, function(err) {
    if (err) {
      throw err;
    }
  });
}

/**
 * Export
 */
export {
  makeFavicons,
  watchFavicons,
  checkForFaviconUpdate
}
