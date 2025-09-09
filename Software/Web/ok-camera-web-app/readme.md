# Mustra, the front-end starter kit

Support: Latest versions of all major browser vendors, Internet Explorer 10 and up
License: MIT (c) Sprawsm doo 

Since we're a UI design shop that does their own front-end development in-house, we always had some kind of a starter kit to kick off the coding process. We always kept things very simple and basic simply because we didn't want to waste time going over the existing styles that may be in place, which is the case with frameworks such as Bootstrap and Foundation. 

The goal we had with Mustra was to create a starting point which we could take in whichever direction we need to take it and do it as fast as possible, regarding the project at hand. This is why the visual styling is kept at a minimum, and why it most likely won't win any beauty contests any time soon. 

Additionally, we wanted to minimize the gruntwork we needed to do for each codebase handover, things such as concatenation, image optimization, etc. This is why Mustra comes with a preconfigured Gruntfile and package.json which provide you with a basic development environment. 

Lastly, Mustra comes with a boilerplate styleguide as an index file which you can use as your UI library and template index. 

At the moment Mustra will set you up with the following: 

- LESS-based CSS preprocessing 
- Default normalization stylesheet based on normalize.css 
- Sensible typographic defaults with some handy helper styles 
- Flexbox-based grid based on FlexboxGrid
- Many helper classes for common styling and behavior presets, and a few UI elements to speed up your work 
- Pug-based templating 
- Gulp assets build system
- Deploy mechanism based on Rsync
- Local web server with BrowserSync

We hope you enjoy using it, and hope it will help you get your work done faster. 

Cheers. 

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

## Working with Mustra

### Folder structure

* `/source` - source files (fonts, images, markup, scripts, styles, email templates, etc.)
* `/dist` - built files that are ready for copying to a web server
* `/tasks` - GulpJS tasks

### Basic setup

When you clone Mustra you should update some information to better suit your project needs:

- update information about your project in `package.js`
- update information in `source/markup/partials/_variables.pug`
- update fonts, colors, sizes and other in `source/less/_variables.less`
- update your favicon in `source/images/favicons/favicon.png`

When you update this information you should rebuild all off the source files:

`$ gulp build`

### Starting the engine

Before you start to change files you should start a local web server because it includes a function to watch all of your changes and rebuild the files automatically:

`$ gulp server`

## Tools and libraries

* [NPM][npm]
* [Yarn][yarn]
* [GulpJS][gulpjs]
* [LESS][less]
* [Pug Node template engine (ex Jade)][pug]

[npm]: https://docs.npmjs.com/getting-started/installing-node
[pug]: http://jade-lang.com/
[less]: http://lesscss.org/
[gulpjs]: http://gulpjs.com/
[gulpjs-install]: https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md
[mustra]: https://gitlab.com/sprawsm/mustra
[flexboxgrid]: http://flexboxgrid.com/
[yarn]: https://yarnpkg.com/
[yarn-install]: https://yarnpkg.com/en/docs/install
