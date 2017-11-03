import $ from 'jquery'

# Avoid using this method to create popover
# Use `tao_popover` view helper method instead
export default (attributes, content) ->
  $popover = $('''
    <tao-popover class="tao-popover">
      <div class="tao-popover-content">
      </div>
      <div class="tao-popover-arrow">
        <i class="arrow arrow-shadow"></i>
        <i class="arrow arrow-border"></i>
        <i class="arrow arrow-basic"></i>
      </div>
    </tao-popover>
  ''').attr attributes

  $popover.find('.tao-popover-content').append content
  $popover.get(0)
