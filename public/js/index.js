$(function() {
    $.get('api/ipsum', function(data) {
        $('#ipsum').text(data);
    });
});
