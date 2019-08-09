function readURL(f, previewId) {
  if (f.files && f.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $(previewId)
        .attr('src', e.target.result);
    };

    reader.readAsDataURL(f.files[0]);
  }
}

$(document).ready(function(){
  $(".preview").change(function() {
    readURL(this, '#img_prev');
  });

  ClassicEditor
  .create( document.querySelector('.editor'))
  .then( editor => {
    console.log( editor );
  } )
  .catch( error => {
    console.error( error );
  });

  $(".select2").select2({
    placeholder: "Select option tags",
    tags: true,
    createTag: function (params) {
      var term = $.trim(params.term);
      if (term === '') {
        return null;
      }
      return {
        id: term,
        text: term,
        newTag: true,
        tokenSeparators: [",", " "]
      }
    }
  }).on("change", function(e) {
    var isNew = $(this).find('[data-select2-tag="true"]');
    if(isNew.length && $.inArray(isNew.val(), $(this).val()) !== -1){
      isNew.replaceWith('<option selected value="' + isNew.val() + '">' + isNew.val() + '</option>');
      $('#console').append('<code>New tag: {"' + isNew.val() + '":"' + isNew.val() + '"}</code><br>');
    }
  });
});
