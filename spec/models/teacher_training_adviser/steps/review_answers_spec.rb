require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::ReviewAnswers do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  let(:answers_by_step) do
    {
      TeacherTrainingAdviser::Steps::Identity => { "first_name": "Joe" },
      TeacherTrainingAdviser::Steps::DateOfBirth => { "date_of_birth": 20.years.ago },
      TeacherTrainingAdviser::Steps::UkAddress => { "address_line1": "7 Main Street" },
      TeacherTrainingAdviser::Steps::UkTelephone => { "address_telephone": "123456789" },
      TeacherTrainingAdviser::Steps::HaveADegree => { "degree_options": "studying" },
      TeacherTrainingAdviser::Steps::ReturningTeacher => {
        "type_id": TeacherTrainingAdviser::Steps::ReturningTeacher::OPTIONS[:returning_to_teaching],
      },
    }
  end

  context "#personal_detail_answers_by_step" do
    before do
      allow_any_instance_of(described_class).to \
        receive(:answers_by_step).and_return answers_by_step
    end
    subject { instance.personal_detail_answers_by_step }

    it {
      is_expected.to eq(answers_by_step.except(
                          TeacherTrainingAdviser::Steps::HaveADegree,
                          TeacherTrainingAdviser::Steps::ReturningTeacher,
                        ))
    }
  end

  context "#other_answers_by_step" do
    before do
      allow_any_instance_of(described_class).to \
        receive(:answers_by_step).and_return answers_by_step
    end
    subject { instance.other_answers_by_step }

    it {
      is_expected.to eq(answers_by_step.slice(
                          TeacherTrainingAdviser::Steps::HaveADegree,
                          TeacherTrainingAdviser::Steps::ReturningTeacher,
                        ))
    }
  end
end
