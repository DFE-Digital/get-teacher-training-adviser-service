module WhatDegreeClassHelper
  def remove_third_and_grade_unknown(degree_class_options)
    degree_class_options.reject! { |k| k.value =~ /Third|grade unknown/ }
  end
end