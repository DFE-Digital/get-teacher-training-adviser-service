module WhatDegreeClassHelper
  def remove_third_and_grade_unknown(degree_class_options)
    degree_class_options.reject! { |k| %w[222750004 222750005].include? k.id }
  end
end
