// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require sigma
//= require sigma.parsers.json/sigma.parsers.json.js
//= require sigma.layout.forceAtlas2/sigma.layout.forceAtlas2.js
//= require_tree .


$(function() {
  $('#chosenCompany').hide();

  $(document).on('click', 'a.choose-company', function() {
    $('#results').html("");
    $('#company-search').hide();

    var companyInfo = JSON.parse($(this).attr('data-company'));

    if($('#chosenCompany').length) {
      // We're choosing a company from the person workflow
      $('#chosenCompany').show();
      $('#chosenCompany h1').text('Add control info for ' + companyInfo.name)
      var $companyForm = $('#chosenCompany form.shareholder-relationship')
      $companyForm.find('input#control_relationship_child_attributes_name').val(companyInfo.name);
      $companyForm.find('input#control_relationship_child_attributes_jurisdiction_code').val(companyInfo.jurisdiction_code);
      $companyForm.find('input#control_relationship_child_attributes_company_number').val(companyInfo.company_number);
    } else {
      // We're choosing a company to add control info for
      var $companyForm = $('form#new_company')
      console.log($companyForm);
      $companyForm.find('input#company_name').val(companyInfo.name);
      $companyForm.find('input#company_jurisdiction_code').val(companyInfo.jurisdiction_code);
      $companyForm.find('input#company_company_number').val(companyInfo.company_number);
      $companyForm.submit();
    }

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
