FactoryBot.define do
  factory :start_teacher_training do
    initial_teacher_training_year_id do
      ApiClient.get_candidate_initial_teacher_training_years.find { |year| year.value.to_i == Time.zone.today.year }.id
    end
  end
end
