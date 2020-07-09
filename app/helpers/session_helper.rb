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
    cdate = session[:registration]["callback_date"]
    cdate.strftime("%d %m %Y")
  end

  def show_callback_time
    session[:registration]["callback_time"]
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

  def show_subject(question)
    subject_id = session[:registration][question]
    ApiClient::get_teaching_subjects.find { |subject| subject.id == subject_id }.value
  end

  def show_have_a_degree
    degree_option = session[:registration]["degree"]
    HaveADegree::OPTIONS.key(degree_option).to_s.capitalize
  end

  def show_what_degree_class
    degree_class = session[:registration]["degree_class"]
    WhatDegreeClass::options.key(degree_class)
  end

  def show_stage_interested_teaching
    stage = session[:registration]["primary_or_secondary"]
    StageInterestedTeaching::OPTIONS.key(stage).to_s.capitalize
  end
end
