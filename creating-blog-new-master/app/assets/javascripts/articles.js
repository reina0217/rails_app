$(function() {
  $('#article_title').on('keyup', function() {
    const count = $(this).val().length;
    $('#title_count').text(count);
  });

  $('#article_text').on('keyup', function() {
    const count = $(this).val().length;
    $('#text_count').text(count);
  });
});
