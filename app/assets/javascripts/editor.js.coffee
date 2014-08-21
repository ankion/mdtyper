@md_editor = (textarea_name) ->
  ta_obj = $("##{textarea_name}")
  ta_obj.hide()
  tb_obj = $("""
  <div class="md-toolbar">
    <div class="btn-toolbar" role="toolbar">
      <div class="btn-group">
        <a href="#" data-name="undo" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-undo"></i></a>
        <a href="#" data-name="redo" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-repeat"></i></a>
      </div>
      <div class="btn-group">
        <a href="#" class="btn btn-default" data-no-turbolink="true">h1</a>
        <a href="#" class="btn btn-default" data-no-turbolink="true">h2</a>
      </div>
      <div class="btn-group">
        <a href="#" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-bold"></i></a>
        <a href="#" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-italic"></i></a>
      </div>
      <div class="btn-group">
        <a href="#" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-quote-left"></i></a>
        <a href="#" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-list-ol"></i></a>
        <a href="#" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-list-ul"></i></a>
      </div>
      <div class="btn-group">
        <a href="#" data-name="more" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-cut"></i></a>
        <a href="#" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-link"></i></a>
        <a href="#" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-file-image-o"></i></a>
      </div>
    </div>
  </div>
  <div>
  """)
  e_obj = $("<div class='md-editor'><div id='editor'></div></div>")
  e_obj.insertAfter(ta_obj.parent())
  tb_obj.insertAfter(ta_obj.parent())
  editor = ace.edit('editor')
  editor.setValue(ta_obj.val(), -1)
  editor.setShowPrintMargin(false)
  editor.renderer.setShowGutter(false)
  editor.setTheme("ace/theme/github")
  editor.getSession().setMode("ace/mode/markdown")
  editor.getSession().on "change", ->
    ta_obj.val editor.getSession().getValue()

  $('.btn-toolbar .btn-group a').on "click", ->
    click_toolbar_button editor, $(this)

click_toolbar_button = (editor, button) ->
  switch button.data('name')
    when 'undo' then editor.undo()
    when 'redo' then editor.redo()
    when 'more' then editor.insert('<!--more-->')
