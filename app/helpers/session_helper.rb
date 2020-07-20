module SessionHelper
  def show_session(question)
    answer = session[:registration][question]
    answer&.downcase == "uk" ? answer&.upcase : answer&.capitalize
  end

  def show_link(step)
    "<a href='#{new_registration_path(step)}'>Change</a>".html_safe
  end

  def show_dob
    dob = session[:registration]["date_of_birth"]
    dob.strftime("%d %m %Y")
  end

  def show_callback_date
    callback_date_start_at = session[:registration]["callback_slot"]
    ApiClient::get_callback_booking_quotas.find { |callback| callback.start_at == callback_date_start_at }.day
  end

  def show_callback_time
    callback_time_start_at = session[:registration]["callback_slot"]
    ApiClient::get_callback_booking_quotas.find { |callback| callback.start_at == callback_time_start_at }.time_slot
  end

  def show_uk_address
    addr1 = session[:registration]["address_line_1"]
    addr2 = session[:registration]["address_line_2"]
    city = session[:registration]["town_city"]
    postcode = session[:registration]["postcode"]
    #do we need these capitalized etc?
    address = [addr1, addr2, city, postcode]
    address.join("<br />").html_safe
  end

  def show_name
    session[:registration]["first_name"].capitalize.to_s + " " + session[:registration]["last_name"].capitalize.to_s
  end

  def show_email
    session[:registration]["email_address"]
  end

  def show_phone
    session[:registration]["telephone_number"]
  end

  def show_country
    country_id = session[:registration]["country_code"]
    ApiClient::get_country_types.find { |country| country.id == country_id }.value
  end

  def show_true_or_false(question)
    answer = session[:registration][question]
    answer == true ? "Yes" : "No"
  end

  def show_yes_or_no(question)
    answer = session[:registration][question]
    answer == "222750000" ? "Yes" : "No"
  end

  def show_subject(question)
    subject_id = session[:registration][question]
    ApiClient::get_teaching_subjects.find { |subject| subject.id == subject_id }.value
  end

  def show_have_a_degree
    degree = session[:registration]["degree"]
    case degree
    when HaveADegree::OPTIONS[:yes]
      "Yes"
    when HaveADegree::OPTIONS[:no]
      "No"
    when HaveADegree::OPTIONS[:equivalent]
      "Equivalent"
    else
      "Studying"
    end
  end

  def show_what_degree_class
    degree_class = session[:registration]["degree_class"]
    WhatDegreeClass::options.key(degree_class)
  end

  def show_stage_interested_teaching
    stage = session[:registration]["primary_or_secondary"]
    StageInterestedTeaching::OPTIONS.key(stage).to_s.capitalize
  end

  def show_start_teacher_training
    start_year = session[:registration]["year_of_entry"]
    StartTeacherTraining::options.key(start_year)
  end

  def show_stage_of_degree
    degree = session[:registration]["degree"]
    Studying::StageOfDegree::options.key(degree).to_s.gsub("_", " ").capitalize
  end
end
