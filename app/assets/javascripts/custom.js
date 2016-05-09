// /home

$(document).ready(function(){
    $(".csstab tr").mouseover(function(){$(this).addClass("over");}).mouseout(function(){$(this).removeClass("over");})
    $('#new_qna').submit(function() {
        var curLength = $("#ask_question").val().length;
        if (curLength == 0) {
            sweetAlert("Oops...", '請勿留空！', "error");
            return false;
        } else {
            return true;
        }
    });
});

function words_deal() {
    var curLength = $("#ask_question").val().length;
    if (curLength > 50) {
        var num = $("#ask_question").val().substr(0, 50);
        $("#ask_question").val(num);
        sweetAlert("Oops...", '超過字數限制，多出的字將被移除！', "error");
    } else {
        $("#textCount").text(50 - $("#ask_question").val().length);
    }
}