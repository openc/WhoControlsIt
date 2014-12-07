// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.cookie
//= require twitter/bootstrap
//= require sigma
//= require sigma.parsers.json/sigma.parsers.json.js
//= require sigma.layout.forceAtlas2/sigma.layout.forceAtlas2.js
//= require_tree .
//= require autocomplete-rails


$(document).ready(function() {
  $('#company_details a.oc_link').getCompanyData();

  $('#topnavbar').affix({
    offset: {
      top: $('#banner').height()
    }
  });
  // $('.toggle').getCompanyData();
});

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
      $companyForm.find('input#control_relationship_child_attributes_jurisdiction').val(companyInfo.jurisdiction_code);
      $companyForm.find('input#control_relationship_child_attributes_company_number').val(companyInfo.company_number);
    } else {
      // We're choosing a company to add control info for
      var $companyForm = $('form#new_company')
      console.log($companyForm);
      $companyForm.find('input#company_name').val(companyInfo.name);
      $companyForm.find('input#company_jurisdiction').val(companyInfo.jurisdiction_code);
      $companyForm.find('input#company_company_number').val(companyInfo.company_number);
      $companyForm.submit();
    }

  });

  $('form.search').on('ajax:success', function(event, data, status, xhr) {
    var $resultsList = $('<ul/>');
    $resultsList.append($('<h3>Choose a company</h3>'))
    $.each(data.results.companies, function(i, elem) {
      $resultsList.append(companyResultLink(elem))
    });
    $('#results').html($resultsList);
  });

  $('.toggle').on('click', function() {
    var el_to_toggle = $(this).data("toggle-el");
    $(el_to_toggle).slideToggle();
  });

});

function populateCompanyData(companyData) {
  var company = companyData.results.company;
  var dlData = {};
  var dlString = '';
  dlData['status'] = company.current_status;
  dlData['company_type'] = company.company_type;
  dlData['registered_address'] = company.registered_address_in_full;
  dlData['incorporation_date'] = company.incorporation_date;
  dlData['dissolution_date'] = company.dissolution_date;
  // if (company.data&&company.data.most_recent) {
  //   var data = $.map(company.data.most_recent, function(d) {
  //     var cd = linkTo(d.datum.title, d.datum.opencorporates_url);
  //     if (d.datum.description) {cd = cd + ' (' + d.datum.description + ')';};
  //     return cd;
  //   } );
  //   dlData['latest_data'] = data.join(', ');
  // };
  if (company.previous_names) {
    var previous_names = $.map(company.previous_names, function(pn) {
      return pn.company_name + ' (' + pn.con_date + ')';
    } );
    dlData['previous_names'] = previous_names.join(', ');
  };
  if (company.corporate_groupings) {
    var corporate_groupings = $.map(company.corporate_groupings, function(cg) {
      return linkTo(cg.corporate_grouping.name, cg.corporate_grouping.opencorporates_url);
    } );
    dlData['corporate_grouping'] = corporate_groupings.join(', ');
  };
  if (company.filings) {
    var filings = $.map(company.filings.slice(0,2), function(f) {
      return '<span class="date">' + f.filing.date + '</span> ' + linkTo(f.filing.title, f.filing.opencorporates_url);
    } );
    dlData['latest_filings'] = filings.join(', ');
  };
  $.each(dlData, function(k,v) {
    dlString = dlString + buildDlEl(k,v);
    } );
  $('dl.attributes').append(dlString);
  $('.ajax_fetcher').fadeOut();
}
function buildDlEl(k, v) {
  return (v ? '<dt>' + toTitleCase(k) + '</dt><dd class="'+ k + '">' + v + '</dd>' : '');
}
function toTitleCase(str)
{
   return str.replace('_',' ').replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
}
function linkTo(txt,url) {
  return '<a href="'+ url + '">' + txt + '</a>'
}
function companyResultLink(company_el) {
  var company = company_el.company;
  var flag_icon = '<img class="flag" src="/images/flags/' + company.jurisdiction_code.split('_')[0] + '.gif">'
  var $chooseCompanyLink = $('<a class="choose-company" />');
  var company_dates = join_non_blank([company.incorporation_date,company.dissolution_date], ' - ');
  var company_number_text = 'company identifier: ' + company.company_number;
  var company_text = company.name + ' ('  + join_non_blank([company.jurisdiction_code.toUpperCase(), company_number_text, company_dates, company.company_type, company.current_status]) + ')'
  $chooseCompanyLink.text(company_text);
  return $('<li>')
    .append(flag_icon)
    .append($chooseCompanyLink.attr("data-company", JSON.stringify(company)))
    .append($('</li>'));
}

function join_non_blank(some_array, separator) {
  separator = separator || ', ';
  return $.map(some_array, function(val) {
    var non_blank = val && !/^\s*$/.test(val);
    return non_blank ? val : null;
  }).join(separator);
}

jQuery.fn.getCompanyData = function () {
  var el = $(this)[0];
  if (el) {
    $('dl.attributes').before("<div class='ajax_fetcher'>Fetching data from OpenCorporates</div>");
    var oc_url = $(this)[0]['href'].replace('opencorporates','api.opencorporates') + '.json?callback=?';
    $.getJSON(oc_url, function(data) { populateCompanyData(data) });
  };
}

