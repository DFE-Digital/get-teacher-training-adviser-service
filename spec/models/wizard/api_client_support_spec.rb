require "rails_helper"

RSpec.describe Wizard::ApiClientSupport do
  class ApiClientTestWizard
    include ::Wizard::ApiClientSupport

    def export_data
      { "first_name" => "Joe", "last_name" => "Bloggs" }
    end
  end

  subject { instance }

  let(:instance) { ApiClientTestWizard.new }

  describe "#export_camelized_hash" do
    subject { instance.export_camelized_hash }

    it { is_expected.to include firstName: "Joe" }
    it { is_expected.to include lastName: "Bloggs" }
  end
end
