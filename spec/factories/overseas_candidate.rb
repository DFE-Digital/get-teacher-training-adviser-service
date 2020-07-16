FactoryBot.define do
  factory :overseas_candidate, class: OverseasCandidate, parent: :callback do
    time_zone { "Hawaii" }
  end
end
