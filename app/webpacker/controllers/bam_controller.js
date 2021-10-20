import ImagePixelBaseController from './image_pixel_base_controller';

export default class extends ImagePixelBaseController {
  static ids = [
    '3SiyrUovKdlqLue/KC4lu',
  ];

  get serviceId() {
    return this.getServiceId('bam-id');
  }

  get serviceFunction() {
    return window.bam;
  }

  initService() {
    // Empty as this is an image tracking pixel.
    window.bam = () => {};
  }

  sendEvent() {
    this.constructor.ids.forEach((id) =>
      this.loadPixel(`https://linkbam.uk/m/${id}.png`)
    );
  }
}
