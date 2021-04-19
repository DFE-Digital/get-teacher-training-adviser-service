require "rails_helper"

RSpec.describe "Feedback" do
  subject { response }

  describe "#new" do
    before { get new_teacher_training_adviser_feedback_path }

    it { is_expected.to have_http_status(:success) }
    it { expect(response.body).to include("Give feedback on this service") }
  end

  describe "#create" do
    let(:params) do
      {
        teacher_training_adviser_feedback: {
          successful_visit: true,
          rating: :satisfied,
        },
      }
    end

    it "creates a Feedback and reirects to a thank you page" do
      allow(ActiveSupport::Notifications).to receive(:instrument).and_call_original
      expect(ActiveSupport::Notifications).to receive(:instrument)
        .with("tta.feedback", instance_of(TeacherTrainingAdviser::Feedback))

      expect { post teacher_training_adviser_feedbacks_path, params: params }.to \
        change(TeacherTrainingAdviser::Feedback, :count).by(1)

      expect(response).to redirect_to(thank_you_teacher_training_adviser_feedbacks_path)
      follow_redirect!
      expect(response.body).to include("Thank you for your feedback.")
    end

    context "when there are errors" do
      let(:params) { { teacher_training_adviser_feedback: { rating: nil } } }

      before { post teacher_training_adviser_feedbacks_path, params: params }

      it { is_expected.to have_http_status(:success) }
      it { expect(response.body).to include("Give feedback on this service") }
      it { expect(response.body).to include("Select an option for how did you feel about the service") }
    end
  end
end
