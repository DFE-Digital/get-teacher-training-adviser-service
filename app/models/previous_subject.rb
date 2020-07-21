class PreviousSubject < Base
  attribute :subject_taught_id, :string

  validates :subject_taught_id, types: { method: :get_teaching_subjects }

  def next_step
    "subject_like_to_teach"
  end
end
