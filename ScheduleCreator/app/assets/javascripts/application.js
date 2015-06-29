// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery
//= require materialize-sprockets

$(document).ready(function(){
    // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
    $('.modal-trigger').leanModal();
});

var last_dept;
var last_courseId;

function take_course(dept, courseId) {
    $('#take_course_title').text("Add Course: " + dept + " " + courseId);
    last_dept = dept;
    last_courseId = courseId;
}


function submit_course() {
    var personal_rating = $('#personal_rating').val();
    var importance = $('#importance').val();
    var difficulty = $('#difficulty').val();
    var grade = $('#grade').val();

    $.ajax({
        url: "/required_courses", // Route to the RequiredCourse Controller
        type: "POST",
        dataType: "json",
        // pass params to create method
        data: { department: last_dept, courseId: last_courseId, personal_rating: personal_rating, importance: importance,
                desired_grade: grade, estimated_difficulty: difficulty},
        complete: function() {},
        success: function() {
            Materialize.toast(last_dept + ' ' + last_courseId + ' was added successfully', 4000);
        },
        error: function() {
            Materialize.toast('There was an error in adding ' + last_dept + ' ' + last_courseId + '. Please try again.', 4000);
        }
    });
}