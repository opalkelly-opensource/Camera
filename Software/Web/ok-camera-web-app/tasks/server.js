/**
 * Server Task
 */
import gulp from 'gulp';
import browserSync from 'browser-sync';
import paths from './lib/paths';
import pluginOptions from './lib/plugin-options';
import vss from 'vinyl-source-stream'
import vb from 'vinyl-buffer'
import vf from 'vinyl-file'

/**
 * Start a web server with live reload
 */
const startServer = () => {
  const server = browserSync.create();

  server.init(pluginOptions.browserSync)

  return server.watch(paths.overwatch, (evt, file) => {
    if (evt === 'change' && file.indexOf('.css') === -1) server.reload()
    if (evt === 'change' && file.indexOf('.css') !== -1)
      vf
        .readSync(file)
        .pipe(vss(file))
        .pipe(vb())
        .pipe(server.stream())
  })
}

/**
 * Export
 */
export default startServer
