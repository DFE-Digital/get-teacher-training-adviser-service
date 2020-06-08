class WhatSubjectDegree < Base
  attribute :degree_subject, :string
  
  validates :degree_subject, inclusion: { in: [
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
    "stage_interested_teaching"
  end
end