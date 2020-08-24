import { Application } from 'stimulus' ;

export default class {
  static initApp(name, controller, serviceId) {
    document.body.setAttribute("data-analytics-" + name + "-id", serviceId) ;
    const application = Application.start() ;
    application.register(name, controller) ;
  }

  static describeAnalytics(name, controller, serviceFunctionName) {
    describe("with no service id", () => {
      beforeEach(() => { this.initApp(name, controller, "") })

      it("Should not register the service", () => {
        expect(typeof(window[serviceFunctionName])).toBe("undefined") ;
      }) ;
    })

    describe("with service id set", () => {
      beforeEach(() => { this.initApp(name, controller, "1234") }) ;

      it("Should register the service", () => {
        expect(typeof(window[serviceFunctionName])).toBe("function") ;
      }) ;
    })
  }
}
