exec = require('executive').interactive

option '-g', '--grep [filter]', 'test filter'
option '-v', '--version [<newversion> | major | minor | patch | build]', 'new version'

task 'clean', 'clean project', (options) ->
  exec 'rm -rf lib'

task 'build', 'build project', (options) ->
  exec 'node_modules/.bin/coffee -bcm -o lib/ src/'

task 'test', 'run tests', ->
  exec "NODE_ENV=test ./node_modules/.bin/mocha
                      --colors
                      --reporter spec
                      --timeout 5000
                      --compilers coffee:coffee-script/register
                      --require source-map-support/register
                      test"

task 'watch', 'watch for changes and recompile project', ->
  exec './node_modules/.bin/coffee -bc -m -w -o lib/ src/'

task 'publish', 'publish project', (options) ->
  exec """
  git push
  git push --tags
  npm publish
  """.split '\n'
