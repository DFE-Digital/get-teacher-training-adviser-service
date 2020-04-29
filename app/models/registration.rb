class Registration
  include ActiveModel::Model
  include ActiveModel::Attributes

  #attribute :current_step, :string
  #attribute :email, :string
  attr_writer :current_step
  attr_accessor :email,
    :first_name,
    :last_name,
    :returning_to_teaching,
    :have_a_degree, 
    :primary_or_secondary,
    :primary_subject_qualified_to_teach,
    :secondary_subject_qualified_to_teach,
    :date_of_birth

  def current_step
    @current_step || steps.first
  end

  def steps
   %w(identity returning_to_teaching primary_or_secondary_branch primary_subject_qualified_to_teach secondary_subject_qualified_to_teach date_of_birth completed)
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

end