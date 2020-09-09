require "rails_helper"

RSpec.describe "BETA feedback banner", type: :request do
  before { get root_path }
  subject { response.body }

  it { is_expected.to match(/beta/) }
  it { is_expected.to match(/This is a new service/) }
end
