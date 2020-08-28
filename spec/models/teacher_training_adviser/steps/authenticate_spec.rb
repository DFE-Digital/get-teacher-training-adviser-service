require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::Authenticate do
  include_context "wizard step"

  it { is_expected.to be_kind_of(::Wizard::Steps::Authenticate) }

  it "calls get_pre_filled_teacher_training_adviser_sign_up on valid save!" do
    attributes = { "timed_one_time_password": "123456" }
    response = GetIntoTeachingApiClient::MailingListAddMember.new
    expect_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
      receive(:get_pre_filled_teacher_training_adviser_sign_up)
      .with("123456", anything)
      .and_return(response)
    subject.assign_attributes(attributes)
    subject.save!
  end
end
