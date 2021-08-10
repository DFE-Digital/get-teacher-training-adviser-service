require "rails_helper"

RSpec.describe "BETA feedback banner", type: :request do
  subject { response.body }

  before { get root_path }

  it { is_expected.to match(/beta/) }
  it { is_expected.to match(/This is a new service/) }
end
