import { Controller } from "stimulus";

export default class extends Controller {
  initialize() {
    $('#company_email').change(function() {
      var email = this.value;
      var valid = /[a-zA-Z_0-9.]+@getmainstreet.com/.test(email);

      if(!valid && email) {
        alert("Please enter a valid email address with @getmainstreet.com")
      }
    })
  }
}
