import CookiePreferences from "../javascript/cookie_preferences"
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["banner", "accept"];

  connect() {
    if (!this.isPreferencesPage()) {
      this.checkforCookie();
    }
  }

  checkforCookie() {
    const cookiePrefs = new CookiePreferences() ;
    if (cookiePrefs.cookieSet)
      return ;

    this.showBanner();
  }

  allowAll(event) {
    event.preventDefault();
    this.element.classList.add('accepted') ;

    const cookiePrefs = new CookiePreferences() ;
    cookiePrefs.allowAll() ;
  }

  showBanner() {
    this.element.classList.remove('hide') ;
    this.acceptTarget.focus() ;
  }

  isPreferencesPage() {
    const path = window.location.href.replace(/^https?:\/\/[^/]+/, '')
    return (path == "/cookie_preference") ;
  }

  hideCookieBanner(event) {
    event.preventDefault() ;
    this.element.classList.add('hide') ;
  }
}
