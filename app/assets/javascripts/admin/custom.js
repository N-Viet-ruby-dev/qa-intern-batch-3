$(document).ready(function() {
  $(".sidebar-dropdown > a").click(function() {
    $(".sidebar-submenu").slideUp(20);
    if ($(this).parent().hasClass("active")) {
      $(".sidebar-dropdown").removeClass("active");
      $(this).parent().removeClass("active");
    } else {
      $(".sidebar-dropdown").removeClass("active");
      $(this).next(".sidebar-submenu").slideDown(20);
      $(this).parent().addClass("active");
    }
  });

  $("#close-sidebar").click(function() {
    $(".page-wrapper").removeClass("toggled");
    $(".dataTables_scrollHeadInner").css('width', '100%')
    $(".table.table-striped.table-bordered.dataTable.no-footer").css('width', '100%')
  });

  $("#show-sidebar").click(function() {
    $(".page-wrapper").addClass("toggled");
    $(".dataTables_scrollHeadInner").css('width', '100%')
    $(".table.table-striped.table-bordered.dataTable.no-footer").css('width', '100%')
  });

  $('#table_id').DataTable({
    scrollY: 500,
    "order": [[ 0, 'DESC' ]],
    "pageLength": 25,
    "columnDefs": [
    { "orderable": false, "targets": [6] },
    ]
  });

// Table tags
$('#container_tags').DataTable({
  scrollY: 500,
  "order": [[ 0, 'DESC' ]],
  "pageLength": 10,
  "columnDefs": [
  { "orderable": false, "targets": [2] },
  ]
});

$('#container_posts').DataTable({
  scrollY: 500,
  "order": [[ 0, 'DESC' ]],
  "pageLength": 10,
  "columnDefs": [
  { "orderable": false, "targets": [5] },
  ]
});

// Admin select2 tags
$(".admin-select").select2({
  placeholder: "Select tags",
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
