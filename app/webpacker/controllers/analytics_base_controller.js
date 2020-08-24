import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    this.triggerEvent() ;
  }

  get isEnabled() {
    return (this.serviceId && this.data.has('action') && this.data.has('event')) ;
  }

  triggerEvent() {
    if (document.documentElement.hasAttribute("data-turbolinks-preview"))
      return ;

    if (!this.isEnabled) return ;

    if (!this.serviceFunction)
      this.initService() ;

    this.sendEvent() ;
  }

  getServiceId(attribute) {
    const value = document.body.getAttribute('data-analytics-' + attribute) ;
    return (value && value.trim() != "") ? value.trim() : null ;
  }

  get serviceAction() {
    return this.data.get('action') ;
  }

  get eventName() {
    return this.data.get('event') ;
  }

  get eventData() {
    let evData = this.data.get('event-data') ;

    if (evData && evData != "")
      return JSON.parse(evData) ;
    else
      return null ;
  }

  sendEvent() {
    let evData = this.eventData ;

    if (evData)
      this.serviceFunction(this.serviceAction, this.eventName, evData) ;
    else
      this.serviceFunction(this.serviceAction, this.eventName) ;
  }

}

