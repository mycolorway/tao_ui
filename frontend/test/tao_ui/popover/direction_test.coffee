import $ from 'jquery'
import { expect } from 'chai'
import Direction from '../../../src/tao/ui/popover/direction'

describe 'Popover Direction Module', ->

  container = null
  popover = null

  beforeEach ->
    container = $('''
      <div class="container" style="width: 500px; height: 500px; position: absolute;">
        <div class="target-1" style="width: 60px; height: 40px; position: absolute; top: 10px; left: 10px;"></div>
        <div class="target-2" style="width: 60px; height: 40px; position: absolute; top: 10px; left: 220px;"></div>
        <div class="target-3" style="width: 60px; height: 40px; position: absolute; top: 10px; right: 10px;"></div>
        <div class="target-4" style="width: 60px; height: 40px; position: absolute; top: 230px; left: 10px;"></div>
        <div class="target-5" style="width: 60px; height: 40px; position: absolute; top: 230px; left: 220px;"></div>
        <div class="target-6" style="width: 60px; height: 40px; position: absolute; top: 230px; right: 10px;"></div>
        <div class="target-7" style="width: 60px; height: 40px; position: absolute; bottom: 10px; left: 10px;"></div>
        <div class="target-8" style="width: 60px; height: 40px; position: absolute; bottom: 10px; left: 220px;"></div>
        <div class="target-9" style="width: 60px; height: 40px; position: absolute; bottom: 10px; right: 10px;"></div>
        <div class="popover" style="width: 100px; height: 100px;"></div>
      </div>
    ''').appendTo('body')

    popover = container.find('.popover')

  afterEach ->
    container.remove()
    container = null
    popover = null

  it 'do direction calculation', ->
    [
      'bottom-right'
      'bottom-center'
      'bottom-left'
      'right-middle'
      'right-middle'
      'left-middle'
      'top-right'
      'top-center'
      'top-left'
    ].forEach (value, i) =>
      direction = new Direction
        popover: popover
        target: container.find(".target-#{i + 1}")
        boundarySelector: '.container'
      expect(direction.toString()).to.equal value
