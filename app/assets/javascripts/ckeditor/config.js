CKEDITOR.editorConfig = function(config) {
	config.language = 'ru';
  config.extraPlugins = 'pbckcode'; // add other plugins here (comma separated)
	config.skin = 'moono-lisa';

	// Toolbar section
	config.removeButtons = 'Underline,Subscript,Superscript,Undo,Cut,Redo,Copy,Paste,PasteText,PasteFromWord,Scayt,Anchor,About';
  config.toolbarGroups = [
		{ name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
		{ name: 'clipboard', groups: [ 'undo', 'clipboard' ] },
		{ name: 'paragraph', groups: [ 'list', 'blocks', 'align' ] },
		{ name: 'insert', groups: [ 'insert' ] },
    '/',
		{ name: 'styles', groups: [ 'styles' ] },
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'links', groups: [ 'links' ] },
		{ name: 'tools', groups: [ 'tools' ] },
		{ name: 'others', groups: [ 'others' ] },
		{ name: 'colors', groups: [ 'colors' ] },
		{ name: 'about', groups: [ 'about' ] },
    { name: 'pbckcode'}
	];

	// Image upload section
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";

  // PBCKCODE CUSTOMIZATION
  config.pbckcode = {
    // An optional class to your pre tag.
    cls: '',
    modes: [['HTML', 'html'], ['CSS', 'css'], ['PHP', 'php'], ['JS', 'javascript'], ['Ruby', 'ruby']], 
    theme: 'ambiance',
    tab_size: '2'
  };
};