import CookiePreferences from "../javascript/cookie_preferences"
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'category' ]
  static values = { saveState: String }

  connect() {
    this.cookiePreferences = new CookiePreferences ;
    this.assignRadios() ;
  }

  assignRadios() {
    for(const category of this.categoryTargets) {
      const categoryName = category.getAttribute("data-category") ;
      const allowed = this.cookiePreferences.allowed(categoryName) ;
      const value = allowed ? '1' : '0' ;
      const radio = category.querySelector('input[type="radio"][value="' + value + '"]') ;

      if (radio)
        radio.checked = true ;
    }
  }

  toggle(event) {
    this.saveStateValue = 'unsaved'
  }

  save(event) {
    event.preventDefault() ;

    for (const categoryFieldset of this.categoryTargets) {
      const category = categoryFieldset.getAttribute('data-category')
      const field = categoryFieldset.querySelector('input[type="radio"]:checked')

      if (field) {
        this.cookiePreferences.setCategory(category, field.value)
      }
    }

    this.saveStateValue = 'saving'
    window.setTimeout(this.finishSave.bind(this), 300)
  }

  finishSave() {
    if (this.saveStateValue == 'saving')
      this.saveStateValue = 'saved'
  }
}
