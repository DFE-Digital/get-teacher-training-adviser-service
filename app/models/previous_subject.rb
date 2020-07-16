class PreviousSubject < Base
  attribute :prev_subject, :string

  validates :prev_subject, types: { method: :get_teaching_subjects }

  def next_step
    "subject_like_to_teach"
  end
end
