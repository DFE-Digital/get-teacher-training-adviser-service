require.context("govuk-frontend/govuk/assets");

import "../styles/application.scss";
import Rails from "@rails/ujs";
import '@hotwired/turbo-rails'
import { initAll } from "govuk-frontend";

// Required by GOV.UK front-end
document.body.className = ((document.body.className) ? document.body.className + ' js-enabled' : 'js-enabled');

Rails.start();
initAll();

import "controllers"
