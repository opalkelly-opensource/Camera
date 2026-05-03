/**
 * Images Task
 */
import gulp from 'gulp';
import newer from 'gulp-newer';
import imagemin from 'gulp-imagemin';
import paths from './lib/paths';

/**
 * Compress images and copy to the destination folder
 */
const compressImages = () => {
  return gulp.src(paths.images.src)
    .pipe(newer(paths.images.dest))
    .pipe(imagemin())
    .pipe(gulp.dest(paths.images.dest));
};

/**
 * Watch changes on images
 */
const watchImages = () => {
  return gulp.watch(paths.images.src, compressImages);
};

/**
 * Export
 */
export {
  compressImages,
  watchImages
}
