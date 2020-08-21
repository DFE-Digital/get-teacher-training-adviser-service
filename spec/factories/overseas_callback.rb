FactoryBot.define do
  factory :overseas_callback, class: OverseasCallback, parent: :callback do
    time_zone { "Hawaii" }
  end
end
