# Shorter version of the readme file

Short description about the project with some important instructions.

## Requirements

1. NPM - Node.js package manager ([install][npm]) or Yarn - Node.js dependency manager ([install][yarn-install])

## Installation

1. Install requirements

2. Clone Mustra repository from GitLab:

    `$ git clone https://gitlab.com/sprawsm/mustra.git`

3. Install required dependencies:

    `$ npm install` or `$ yarn install`

4. Build source files:

    `$ gulp build`

5. Start local web server and watch task with:

    `$ gulp`

## Folder structure

* `/source` - source files (fonts, images, markup, scripts, styles, email templates, etc.)
* `/dist` - built files that are ready for copying to a web server
* `/tasks` - GulpJS tasks

## Tools and libraries

* [NPM][npm]
* [Yarn][yarn]
* [GulpJS][gulpjs]
* [LESS][less]
* [Pug Node template engine (ex Jade)][pug]
* [Mustra starter kit][mustra]

[npm]: https://docs.npmjs.com/getting-started/installing-node
[pug]: http://jade-lang.com/
[less]: http://lesscss.org/
[gulpjs]: http://gulpjs.com/
[gulpjs-install]: https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md
[mustra]: https://gitlab.com/sprawsm/mustra
[flexboxgrid]: http://flexboxgrid.com/
[yarn]: https://yarnpkg.com/
[yarn-install]: https://yarnpkg.com/en/docs/install
