const Cookies = require('js-cookie') ;
import CookiePreferences from "cookie_preferences" ;
import { Application } from 'stimulus' ;
import CookieAcceptanceController from 'cookie-acceptance_controller.js' ;

describe('CookieAcceptanceController', () => {
  let cookieName = "gta-cookie-preferences-v1" ;

  document.body.innerHTML =
  `<div data-controller="cookie-acceptance" class="hide">
      <div data-cookie-acceptance-target="banner">
          <p>Explanation</p>
          <a href="#" data-action="cookie-acceptance#allowAll"
                      data-cookie-acceptance-target="accept">Accept</a>
          <a href="/prefs">Edit prefs</a>
      </div>
      <div>
        <p>Confirmation text</p>
        <a href="#" data-action="cookie-acceptance#hideCookieBanner">Hide</a>
      </div>
  </div>`;

  const initApp = function() {
    const application = Application.start() ;
    application.register('cookie-acceptance', CookieAcceptanceController);
  }

  function getBanner() {
    return document.querySelector('[data-controller="cookie-acceptance"]');
  }

  beforeEach(() => {
    Cookies.remove("gta-cookie-preferences-v1") ;
  }) ;

  describe("when the cookie is set", () => {
    beforeEach(() => {
      const data = JSON.stringify({functional: true}) ;
      Cookies.set("gta-cookie-preferences-v1", data) ;

      initApp() ;
    }) ;

    it('does not show the cookie acceptance dialog', () => {
      expect(getBanner().classList.contains('hide')).toBe(true);
    })
  });

  describe("when the cookie is not set", () => {
    beforeEach(() => { initApp() }) ;

    it('shows the cookie acceptance dialog', () => {
      expect(getBanner().classList.contains('hide')).toBe(false);
    })
  });


  describe("clicking the accept button", () => {
    beforeEach(() => { initApp() })

    it('sets the cookie', () => {
      document.querySelector('a[data-action="cookie-acceptance#allowAll"]').click() ;
      expect((new CookiePreferences).allowed('marketing')).toBe(true);
    })

    it('shows the confirmation dialog', () => {
      document.querySelector('a[data-action="cookie-acceptance#allowAll"]').click() ;
      expect(getBanner().classList.contains('accepted')).toBe(true);
    })

    it("followed by clicking the hide button will hide the banner", () => {
      document.querySelector('a[data-action="cookie-acceptance#allowAll"]').click() ;
      document.querySelector('a[data-action="cookie-acceptance#hideCookieBanner"]').click()
      expect(getBanner().classList.contains('hide')).toBe(true)
    })
  });

});
