class SubjectLikeToTeach < Base
  extend ApiOptions

  attribute :like_to_teach, :string

  validates :like_to_teach, types: { method: :get_teaching_subjects, message: "Please select maths, physics or modern foreign language" }

  def self.options
    generate_api_options(ApiClient::get_teaching_subjects)
  end

  def next_step
    "date_of_birth"
  end
end
