{module, test} = QUnit

module 'TaoPopover.Direction',

  beforeEach: ->
    @container = $('''
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

    @popover = @container.find('.popover')

  afterEach: ->
    @container.remove()
    @container = null
    @popover = null

, ->

  test 'direction calculation', (assert) ->
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
    ].forEach (expect, i) =>
      direction = new TaoPopover.Direction
        popover: @popover
        target: @container.find(".target-#{i + 1}")
        boundarySelector: '.container'
      assert.equal direction.toString(), expect
