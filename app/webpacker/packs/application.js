require.context("govuk-frontend/govuk/assets");
require("packs/back_link");
require("packs/google_analytics");

import "../styles/application.scss";
import Rails from "rails-ujs";
import Turbolinks from "turbolinks";
import { initAll } from "govuk-frontend";

Rails.start();
Turbolinks.start();
initAll();
