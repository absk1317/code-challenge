import { Controller } from "stimulus";

export default class extends Controller {
  initialize() {
    // for validations on forms for create and update
    $('#submit_company').click(function() {
      var email = $('#company_email').value;
      var validEmail = /[a-zA-Z_0-9.]+@getmainstreet.com/.test(email);

      if(!validEmail && email) {
        alert("Please enter a valid email address with @getmainstreet.com");
        return false
      }
    })
  }
}
