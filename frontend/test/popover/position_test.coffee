import $ from 'jquery'
import { expect } from 'chai'
import Direction from '../../src/popover/direction'
import Position from '../../src/popover/position'

describe 'Popover Position Module', ->

  container = null
  popover = null

  beforeEach ->
    container = $('''
      <div class="container" style="width: 500px; height: 500px; position: relative;">
        <div class="target-1" style="width: 60px; height: 40px; position: absolute; top: 10px; left: 10px;"></div>
        <div class="target-2" style="width: 60px; height: 40px; position: absolute; top: 10px; left: 220px;"></div>
        <div class="target-3" style="width: 60px; height: 40px; position: absolute; top: 10px; right: 10px;"></div>
        <div class="target-4" style="width: 60px; height: 40px; position: absolute; top: 230px; left: 10px;"></div>
        <div class="target-5" style="width: 60px; height: 40px; position: absolute; top: 230px; left: 220px;"></div>
        <div class="target-6" style="width: 60px; height: 40px; position: absolute; top: 230px; right: 10px;"></div>
        <div class="target-7" style="width: 60px; height: 40px; position: absolute; bottom: 10px; left: 10px;"></div>
        <div class="target-8" style="width: 60px; height: 40px; position: absolute; bottom: 10px; left: 220px;"></div>
        <div class="target-9" style="width: 60px; height: 40px; position: absolute; bottom: 10px; right: 10px;"></div>
        <div class="popover" style="width: 100px; height: 100px;">
          <div class="tao-popover-arrow" style="width: 16px; height: 16px;"></div>
        </div>
      </div>
    ''').appendTo('body')

    popover = container.find('.popover')

  afterEach: ->
    container.remove()
    container = null
    popover = null

  it 'do position calculation', ->
    [
      '58,10'
      '58,200'
      '58,390'
      '200,78'
      '200,288'
      '200,322'
      '342,10'
      '342,200'
      '342,390'
    ].forEach (value, i) =>
      direction = new Direction
        popover: popover
        target: container.find(".target-#{i + 1}")
        boundarySelector: '.container'

      position = new Position
        popover: popover
        target: container.find(".target-#{i + 1}")
        direction: direction.directions

      expect("#{Math.round position.top},#{Math.round position.left}").to.equal value
