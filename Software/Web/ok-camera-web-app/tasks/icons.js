/**
 * Icons Task
 */
import gulp from 'gulp';
import newer from 'gulp-newer';
import svgmin from 'gulp-svgmin';
import svgstore from 'gulp-svgstore';
import path from 'path';
import paths from './lib/paths';

/**
 * Make icon sprite
 */
const makeIconSprite = () => {
  return gulp.src(paths.icons.src)
    .pipe(newer(paths.icons.dest + paths.icons.destFile))
    .pipe(svgmin(function (file) {
        var prefix = path.basename(file.relative, path.extname(file.relative));
        return {
            plugins: [{
                cleanupIDs: {
                    prefix: prefix + '-',
                    minify: true
                }
            }]
        };
    }))
    .pipe(svgstore())
    .pipe(gulp.dest(paths.icons.dest));
};

/**
 * Copy icons to the destination folder
 */
const copyIcons = () => {
  return gulp.src(paths.icons.src)
    .pipe(newer(paths.icons.destIcons))
    .pipe(svgmin())
    .pipe(gulp.dest(paths.icons.destIcons));
};

/**
 * Watch changes on icons
 */
const watchIcons = () => {
  return gulp.watch(paths.icons.watch, gulp.parallel(makeIconSprite, copyIcons));
};

/**
 * Export
 */
export {
  makeIconSprite,
  copyIcons,
  watchIcons
}
