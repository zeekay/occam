should   = (require 'chai').should()
occam    = require '../lib'

markdown = require 'occam-source-markdown'
jade     = require 'occam-source-jade'

describe 'occam', ->
  occam = (require 'occam')
    '/app.js':
      source: ->
        requisite.bundle entry: 'src/app.coffee'

      render: (bundle) ->
        {code, map} = bundle.toString
          minify: true

    '/blog/:date/:title/index.html':
      context:
        layout:    'src/post.jade'
        blogTitle: 'My blog'
        copyright: '2016 Ludela, Inc'

      source: ->
        yield
          date:     '2016-10-27'
          title:    'hello'
          updatedAt: Date.now()
          content:   ''

        yield
          date:     '2016-10-28'
          title:    'hello'
          updatedAt: Date.now()
          content:   ''

      render: (content) ->
        template = jade.compile @layout
        yield template @

    '/images/*.png':
      context:
      reader:
      reduce:

      source: occam.glob 'src/images/*.png'
      render: occam.copy

    '/product/:sku':
      context:
        layout:    'src/product.jade'
        blogTitle: 'Ludela #{productName}'

      source: ->
        await api.product.list()

      render: (product) ->
        template = jade.compile @layout
        ctx:
          product: product

        yield template ctx

  files = await occam.generate()
