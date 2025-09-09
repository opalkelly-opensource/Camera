/**
 * Plugins options
 */
import handleErrors from './errors';
import fs from 'fs';
import paths from './paths';

const pkg = require('../../package.json');
const deploy = fs.existsSync('./deploy.js') ?
                 require('../../deploy.js') :
                 require('../../deploy.example.js');

const pluginOptions = {
  plumber: {
    errorHandler: handleErrors
  },
  sass: {
    outputStyle: 'expanded',
    errLogToConsole: false
  },
  sassMin: {
    outputStyle: 'compressed'
  },
  autoprefixer: {
    browsers: ['last 3 versions']
  },
  pug: {
    pretty: true
  },
  size: {
    showFiles: true
  },
  rename: {
    suffix: '.min'
  },
  favicons: {
    masterPicture: paths.favicons.src,
    dest: paths.favicons.dest,
    iconsPath: paths.favicons.dest,
    design: {
        ios: {
            pictureAspect: 'noChange',
            assets: {
                ios6AndPriorIcons: false,
                ios7AndLaterIcons: false,
                precomposedIcons: false,
                declareOnlyDefaultIcon: true
            }
        },
        desktopBrowser: {},
        windows: {
            pictureAspect: 'noChange',
            onConflict: 'override',
            assets: {
                windows80Ie10Tile: false,
                windows10Ie11EdgeTiles: {
                    small: false,
                    medium: true,
                    big: false,
                    rectangle: false
                }
            }
        },
        androidChrome: {
            pictureAspect: 'noChange',
            manifest: {
                name: pkg.name,
                display: 'standalone',
                orientation: 'notSet',
                onConflict: 'override',
                declared: true
            },
            assets: {
                legacyIcon: false,
                lowResolutionIcons: false
            }
        },
        safariPinnedTab: {
            pictureAspect: 'blackAndWhite',
        }
    },
    settings: {
        scalingAlgorithm: 'Mitchell',
        errorOnImageTooSmall: false
    },
    markupFile: paths.favicons.dataFile
  },
  rsync: {
    root: paths.destDir,
    hostname: deploy.staging.hostname,
    username: deploy.staging.username,
    destination: deploy.staging.destination,
    archive: true,
    incremental: true,
    recursive: true,
    compress: true,
    clean: true,
    silent: false,
    progress: false,
    command: false,
    dryrun: false,
    exclude: deploy.staging.exclude
  },
  rsyncLocal: {
    source: deploy.local.source,
    destination: deploy.local.destination,
    exclude: deploy.local.exclude
  },
  browserSync: {
    port: 3001,
    server: {
      baseDir: paths.destDir,
    },
  },
}

/**
 * Export
 */
export default pluginOptions
