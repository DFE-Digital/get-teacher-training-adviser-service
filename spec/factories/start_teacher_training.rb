FactoryBot.define do
  factory :start_teacher_training do
    intital_teacher_training_year_id {
      ApiClient::get_candidate_initial_teacher_training_years.find { |year| year.value.to_i == Date.today.year }.id
    }
  end
end
