class QualifiedToTeach < Base
  attribute :qualified_subject, :string

  validates :qualified_subject, inclusion: { in: [
    'Art and design', 
    'Biology',
    'Business studies', 
    'Chemistry',
    'Citizenship', 
    'Classics',
    'Computing', 
    'Dance',
    'Design and technology',
    'Drama',
    'Economic', 
    'English',
    'French',
    'Geography', 
    'German',
    'Health and social care', 
    'History',
    'Languages (other)', 
    'Maths',
    'Media studies', 
    'French',
    'Music',
    'Physical education', 
    'Physics',
    'Physics with maths',
    'Primary psychology',
    'Religious education',
    'Social sciences',
    'Spanish',
    'Vocational health'] 
  }

  def next_step
    "date_of_birth" 
  end

end 