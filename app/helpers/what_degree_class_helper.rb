module WhatDegreeClassHelper
  def remove_third_and_grade_unknown(degree_class_options)
    degree_class_options.reject! { |k| ["Third class or below", "Pass (grade unknown)"].include? k.value }
  end
end
