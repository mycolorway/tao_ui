import $ from 'jquery'
import { expect } from 'chai'
import { Component } from '@mycolorway/tao'
import Popover from '../../src/popover'

describe 'Popover Element',
  target = null
  popover = null

  beforeEach (done) ->
    target = $('''
      <span class="popover-target">Target</span>
    ''').appendTo 'body'
    popover = Popover.create
      'target-selector': '.popover-target'
      'target-traversal': 'prev'
    , 'lalala'
    popover.jq.appendTo 'body'

    setTimeout -> done()

  afterEach ->
    target.remove()
    popover.jq.remove()
    popover = null

  it 'inherits from Tao Component', ->
    expect(popover instanceof Component).to.be.ok

  it 'has active attribute', ->
    expect(popover.active).to.be.false
    expect(popover.hasAttribute('active')).to.not.be.ok
    expect(popover.direction).to.equal ''
    expect(popover.target.get(0)).to.equal target.get(0)

    popover.active = true
    expect(popover.active).to.be.true
    expect(popover.hasAttribute('active')).to.be.ok
    expect(popover.direction).to.equal 'right-middle'

  it 'can be moved', (done) ->
    $container = $('''
      <div class="container">
        <span class="popover-target test-target"></span>
      </div>
    ''').appendTo 'body'
    popover.jq.appendTo $container

    setTimeout =>
      expect(popover.target.hasClass('test-target')).to.be.ok
      expect(popover.active).to.be.false

      popover.triggerEl.click()
      expect(popover.active).to.be.true

      $container.remove()
      done()
