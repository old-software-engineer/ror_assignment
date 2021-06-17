import 'bootstrap'
import 'cocoon-js'
import $ from 'jquery'

import 'selectize/dist/js/standalone/selectize.min'
import 'selectize/dist/css/selectize.css'

import flatpickr from 'flatpickr'
import { Japanese } from 'flatpickr/dist/l10n/ja.js'

import 'styles/theme/theme.min.css'
import 'vendors/theme.js'

import 'styles/dashboard.scss'

require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

window.$ = $

$(document).on('turbolinks:load', () => {
  const initializeFlatpicker = () => {
    const defaultOptions = { locale: Japanese, altFormat: 'y年m月d日', allowInput: true }
    flatpickr('[data-toggle="flatpickr"]', defaultOptions)
    flatpickr('[data-toggle="flatpickr-datetime"]', {
      ...defaultOptions,
      enableTime: true,
      altFormat: 'Y年m月d日 H時i分'
    })
  }

  initializeFlatpicker()
  $(window).on('cocoon:after-insert', initializeFlatpicker)

  $('#txt_name').keyup(function(){
    // Search Text
    var search = $(this).val();

    // Hide all table tbody rows
    $('table tbody tr').hide();

    // Count total search result
    var len = $('table tbody tr:not(.notfound) td:nth-child(6):contains("'+search+'")').length;

    if(len > 0){
      // Searching text in columns and show match row
      $('table tbody tr:not(.notfound) td:contains("'+search+'")').each(function(){
        $(this).closest('tr').show();
      });
    }else{
      $('.notfound').show();
    }
  });
})
