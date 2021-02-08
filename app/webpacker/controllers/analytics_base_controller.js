import CookiePreferences from "../javascript/cookie_preferences"
import { Controller } from "stimulus"

export default class extends Controller {
  static values = {
    action: String,
    event: String,
    eventData: Object
  }

  connect() {
    const cookiePrefs = new CookiePreferences() ;

    if(cookiePrefs.allowed(this.cookieCategory)) {
      this.triggerEvent() ;
    } else {
      this.cookiesAcceptedHandler = this.cookiesAcceptedChecker.bind(this) ;
      document.addEventListener("cookies:accepted", this.cookiesAcceptedHandler) ;
    }
  }

  disconnect() {
    if (this.analyticsAcceptedHandler) {
      document.removeEventListener("cookies:accepted", this.cookiesAcceptedHandler) ;
    }
  }

  get cookieCategory() {
    return 'marketing' ;
  }

  get isEnabled() {
    return (this.serviceId && this.hasActionValue) ;
  }

  triggerEvent() {
    if (document.documentElement.hasAttribute("data-turbolinks-preview"))
      return ;

    if (!this.isEnabled) return ;

    if (!this.serviceFunction)
      this.initService() ;

    this.sendEvent() ;
  }

  cookiesAcceptedChecker(event) {
    if (event.detail?.cookies?.includes(this.cookieCategory))
      this.triggerEvent() ;
  }

  getServiceId(attribute) {
    const value = document.body.getAttribute('data-analytics-' + attribute) ;
    return (value && value.trim() != "") ? value.trim() : null ;
  }

  get serviceAction() {
    if (this.hasActionValue)
      return this.actionValue ;
  }

  get eventName() {
    if (this.hasEventValue)
      return this.eventValue ;
  }

  get eventData() {
    if (typeof(this.parsedEventData) != "undefined")
      return this.parsedEventData ;

    this.parsedEventData = null ;
    if (this.hasEventDataValue)
      this.parsedEventData = this.eventDataValue ;

    return this.parsedEventData ;
  }

  sendEvent() {
    if (this.eventData)
      this.serviceFunction(this.serviceAction, this.eventName, this.eventData) ;
    else if (this.eventName)
      this.serviceFunction(this.serviceAction, this.eventName) ;
    else
      this.serviceFunction(this.serviceAction) ;
  }

}

