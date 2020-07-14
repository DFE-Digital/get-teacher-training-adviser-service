require "rails_helper"

RSpec.describe ApiClient do # are these covered by the gem tests?
  subject { described_class }

  describe "class methods" do
    it "calls the defined methods" do
      expect(subject).to receive(:get_teaching_subjects)
      subject.get_teaching_subjects

      expect(subject).to receive(:get_candidate_initial_teacher_training_years)
      subject.get_candidate_initial_teacher_training_years

      expect(subject).to receive(:get_qualification_degree_status)
      subject.get_qualification_degree_status

      expect(subject).to receive(:get_qualification_uk_degree_grades)
      subject.get_qualification_uk_degree_grades

      expect(subject).to receive(:get_qualification_types)
      subject.get_qualification_types

      expect(subject).to receive(:get_country_types)
      subject.get_country_types

      expect(subject).to receive(:get_candidate_retake_gcse_status)
      subject.get_candidate_retake_gcse_status

      expect(subject).to receive(:get_callback_booking_quotas)
      subject.get_callback_booking_quotas
    end
  end

  describe "ping test" do # just a healthcheck for the dev api
    xit "returns a 200" do
      uri = URI("https://get-into-teaching-api-dev.london.cloudapps.digital/api/types/qualification/degree_status")
      req = Net::HTTP::Get.new(uri)
      req["Authorization"] = Rails.application.credentials.config[:api_key]
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") { |http| http.request(req) }
      expect(res.code).to eq("200")
    end
  end
end
