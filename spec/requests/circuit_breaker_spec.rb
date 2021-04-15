require "rails_helper"

RSpec.describe "Circuit breaker" do
  let(:error) { GetIntoTeachingApiClient::CircuitBrokenError }

  before do
    allow_any_instance_of(
      GetIntoTeachingApiClient::PickListItemsApi,
    ).to receive(:get_qualification_degree_status).and_raise(error)

    expect(Sentry).to receive(:capture_exception).with(error)
  end

  context "when the API returns a CircuitBrokenError" do
    it "the TeacherTrainingAdviser::Steps controller redirects to an error page" do
      get teacher_training_adviser_step_path(TeacherTrainingAdviser::Steps::StageOfDegree.key)
      expect(response).to redirect_to(teacher_training_adviser_not_available_path)
    end
  end
end
