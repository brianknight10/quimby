function handleFileSelect(evt) {
    var files = evt.target.files;
    f = files[0];

    var reader = new FileReader();

    reader.onload = (function(theFile) {
        return function(e) {
          jQuery( '#secret_text' ).val( e.target.result );
        };
    })(f);

    reader.readAsText(f);
  }

document.getElementById('secret_file').addEventListener('change', handleFileSelect, false);
