class PreviousSubject < Base
  attribute :prev_subject, :string

  validates :prev_subject, presence: true

  def next_step
    "subject_like_to_teach"
  end

end 