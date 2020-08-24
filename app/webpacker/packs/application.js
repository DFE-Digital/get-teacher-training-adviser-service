require.context("govuk-frontend/govuk/assets");
require("scripts/back_link");
require("scripts/google_analytics");

import "../styles/application.scss";
import Rails from "rails-ujs";
import Turbolinks from "turbolinks";
import { initAll } from "govuk-frontend";

Rails.start();
Turbolinks.start();
initAll();

import "controllers"
