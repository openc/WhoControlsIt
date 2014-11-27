// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
$(function() {
  $('#chosenCompany').hide();

  $(document).on('click', 'a.choose-company', function() {
    $('#results').html("");
    $('#company-search').hide();
    $('#chosenCompany').show();
    var companyInfo = JSON.parse($(this).attr('data-company'));
    $('#chosenCompany h1').text('Add control info for ' + companyInfo.name)

    var $shareholderForm = $('#chosenCompany form.shareholder-relationship')
    $shareholderForm.find('input#control_relationship_child_attributes_name').val(companyInfo.name);
    $shareholderForm.find('input#control_relationship_child_attributes_jurisdiction_code').val(companyInfo.jurisdiction_code);
    $shareholderForm.find('input#control_relationship_child_attributes_company_number').val(companyInfo.company_number);
  });

  $('form.search').on('ajax:success', function(event, data, status, xhr) {
    var $resultsList = $('<ul/>')
    $.each(data.results.companies, function(i, elem) {
      var $chooseCompanyLink = $('<a class="btn btn-default choose-company" />');
      $chooseCompanyLink.text("choose");
      $resultsList.append($('<li><span>' + elem.company.name + '</span></li>')
        .append($chooseCompanyLink.attr("data-company", JSON.stringify(elem.company))))
    })
  $('#results').html($resultsList);
  });
});
