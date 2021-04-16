require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Feedback do
  include_context "sanitize fields", %i[unsuccessful_visit_explanation improvements]

  context "attributes" do
    it { is_expected.to respond_to :rating }
    it { is_expected.to respond_to :successful_visit }
    it { is_expected.to respond_to :unsuccessful_visit_explanation }
    it { is_expected.to respond_to :improvements }
    it do
      is_expected.to define_enum_for(:rating).with(%i[
        very_satisfied
        satisfied
        neither_satisfied_or_dissatisfied
        dissatisfied
        very_dissatisfied
      ])
    end
  end

  context "validation" do
    it { is_expected.to validate_presence_of(:rating) }
    it { is_expected.to validate_inclusion_of(:successful_visit).in_array([true, false]) }

    context "when successful_visit is false" do
      before { allow(subject).to receive(:successful_visit) { false } }
      it { is_expected.to validate_presence_of(:unsuccessful_visit_explanation) }
    end

    context "when successful_visit is nil" do
      before { allow(subject).to receive(:successful_visit) { nil } }
      it { is_expected.not_to validate_presence_of(:unsuccessful_visit_explanation) }
    end

    context "when successful_visit is true" do
      before { allow(subject).to receive(:successful_visit) { true } }
      it { is_expected.not_to validate_presence_of(:unsuccessful_visit_explanation) }
    end
  end
end
