/**
 * Paths
 */
import fs from 'fs';

const srcDir                = 'source/';
const destDir               = 'dist/';
const npmVendorsDir         = 'node_modules/';
const pkg                   = require('../../package.json');

const paths = {
  destDir: destDir,
  styles: {
    src: [
      srcDir + 'scss/styles.scss',
      srcDir + 'scss/styleguide.scss'
    ],
    dest: destDir + 'assets/css/',
    watch: srcDir + 'scss/**/*.scss'
  },
  scripts: {
    src: [
      npmVendorsDir + 'jquery/dist/jquery.js',
      npmVendorsDir + 'bootstrap/js/dist/modal.js',
      npmVendorsDir + 'bootstrap/js/dist/dropdown.js',
      npmVendorsDir + 'bootstrap/js/dist/util.js',
      npmVendorsDir + 'bootstrap/js/dist/tab.js',
      npmVendorsDir + 'bootstrap/js/dist/collapse.js',
      npmVendorsDir + 'slick-carousel/slick/slick.js',
      srcDir + 'js/**/*.js',
      '!source/js/jquery.throttle-debounce.js'
    ],
    srcCopy: [
      npmVendorsDir + 'popper.js/dist/umd/popper.js',
      npmVendorsDir + 'svg4everybody/dist/svg4everybody.js',
      srcDir + 'js/jquery.throttle-debounce.js'
    ],
    dest: destDir + 'assets/js/',
    destFile: 'app.js',
    destMinFile: 'app.min.js'
  },
  markup: {
    src: [
      srcDir + 'markup/**/*.pug',
      '!source/markup/partials/**/*.pug',
      '!source/markup/styleguide/*.pug'
    ],
    dest: destDir,
    watch: srcDir + 'markup/**/*.pug'
  },
  images: {
    src: [
      srcDir + 'images/**/*.*',
      '!source/images/favicons/*.*',
      '!source/images/icons/*.svg',
    ],
    dest: destDir + 'assets/images/'
  },
  icons: {
    src: srcDir + 'images/icons/*.svg',
    dest: destDir + 'assets/images/',
    destFile: 'icons.svg',
    destIcons: destDir + 'assets/images/icons/',
    watch: srcDir + 'images/icons/*.svg'
  },
  favicons: {
    src: srcDir + 'images/favicons/favicon.png',
    dest: destDir + 'assets/images/favicons/',
    dataFile: srcDir + 'images/favicons/favicon-data.json',
    androidName: pkg.name
  },
  fonts: {
    src: srcDir + 'fonts/**/*',
    dest: destDir + 'assets/fonts/'
  },
  files: {
    src: [
        srcDir + 'markup/*.{php,txt}',
        srcDir + 'markup/.htaccess'
    ],
    dest: destDir
  },
  overwatch: destDir + '**/*.{html,js,css,jpg,png,svg,txt,php,htaccess}'
};

/**
 * Export
 */
export default paths
