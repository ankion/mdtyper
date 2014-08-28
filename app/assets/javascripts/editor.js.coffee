@md_editor = (textarea_name) ->
  ta_obj = $("##{textarea_name}")
  ta_obj.hide()
  tb_obj = $("""
  <div class="md-toolbar">
    <div class="btn-toolbar" role="toolbar">
      <div class="btn-group">
        <a href="#undo" data-name="undo" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-undo"></i></a>
        <a href="#redo" data-name="redo" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-repeat"></i></a>
      </div>
      <div class="btn-group">
        <a href="#more" data-name="more" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-cut"></i></a>
        <a href="#link" data-name="link" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-link"></i></a>
        <a href="#image" data-name="image" class="btn btn-default" data-no-turbolink="true"><i class="fa fa-file-image-o"></i></a>
      </div>
    </div>
  </div>
  <div>
  """)
  e_obj = $("<div class='md-editor'><div id='editor'></div></div>")
  e_obj.insertAfter(ta_obj.parent())
  tb_obj.insertAfter(ta_obj.parent())
  editor = ace.edit('editor')
  editor.session.setValue(ta_obj.val(), -1)
  editor.setShowPrintMargin(false)
  editor.session.setUseWrapMode(true)
  editor.renderer.setShowGutter(false)
  editor.setTheme("ace/theme/github")
  editor.getSession().setMode("ace/mode/markdown")
  editor.getSession().on "change", ->
    ta_obj.val editor.getSession().getValue()

  $('.btn-toolbar .btn-group a[data-name=link]').popover
      html: true
      placement: 'bottom'
      title: 'Link'
      content: """
      <div class="toolbar-popover link-popover">
        <div class="form-group">
          <input type="text" id="link-href" class="form-control" placeholder="URL">
        </div>
        <div class="form-group">
          <input type="text" id="link-text" class="form-control" placeholder="Text">
        </div>
        <div class="form-group">
          <input type="text" id="link-title" class="form-control" placeholder="Title (Optional)">
        </div>
        <a href="#insert-link" data-name="insert-link" class="btn btn-success">Insert</a>
      </div>
      """
  $('.btn-toolbar .btn-group a[data-name=image]').popover
    html: true
    placement: 'bottom'
    title: """
      <span>Image</span>
      <a href="#upload-image" data-name="upload-image" data-no-turbolink="true" class="btn btn-default btn-xs pull-right">Upload</a>
    """
    content: """
      <div class="toolbar-popover image-popover">
        <div class="form-group">
          <input type="text" id="image-href" class="form-control" placeholder="URL">
        </div>
        <div class="form-group">
          <input type="text" id="image-text" class="form-control" placeholder="Text">
        </div>
        <div class="form-group">
          <input type="text" id="image-title" class="form-control" placeholder="Title (Optional)">
        </div>
        <a href="#insert-image" data-name="insert-image" class="btn btn-success">Insert</a>
      </div>
    """

  $('.btn-toolbar .btn-group a').on "click.toolbar", ->
    click_toolbar_button editor, $(this)

click_toolbar_button = (editor, button) ->
  switch button.data('name')
    when 'undo' then editor.undo()
    when 'redo' then editor.redo()
    when 'more'
      editor.navigateLineEnd()
      editor.insert('\n<!--more-->\n')
    when 'link'
      $('.btn-toolbar a').off("click.toolbar").on "click.toolbar", ->
        click_toolbar_button editor, $(this)
    when 'insert-link' 
      editor.navigateLineEnd()
      if $('#link-title').val().length > 0
        link_title = " \"#{$('#link-title').val()}\""
      else
        link_title = ''
      editor.insert("\n[#{$('#link-text').val()}](#{$('#link-href').val()}#{link_title})\n")
      $('.btn-toolbar .btn-group a[data-name=link]').popover('hide')
    when 'image'
      $('.btn-toolbar a').off("click.toolbar").on "click.toolbar", ->
        click_toolbar_button editor, $(this)
    when 'insert-image' 
      editor.navigateLineEnd()
      if $('#image-title').val().length > 0
        image_title = " \"#{$('#image-title').val()}\""
      else
        image_title = ''
      editor.insert("\n![#{$('#image-text').val()}](#{$('#image-href').val()}#{image_title})\n")
      $('.btn-toolbar .btn-group a[data-name=image]').popover('hide')
    when 'upload-image'
      filepicker.pick (InkBlob) ->
        $('#image-href').val(InkBlob.url)
        $('#image-text').val(InkBlob.filename)
  editor.focus()
