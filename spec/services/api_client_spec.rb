require "rails_helper"

RSpec.describe ApiClient do # are these covered by the gem tests?
  subject { described_class }
  let(:body) { { "customer_info" => "hi there" } }

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

      expect(subject).to receive(:sign_up_teacher_training_advisor_candidate).with(body)
      subject.sign_up_teacher_training_advisor_candidate(body)
    end
  end
end
