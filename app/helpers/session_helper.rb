module SessionHelper
  def show_session(question)
    answer = session[:registration][question]
    answer&.downcase == 'uk' ? answer&.upcase : answer&.capitalize
  end

  def show_link(step)
    "<a href='#{ new_registration_path(step) }'>Change</a>".html_safe
  end

  def show_dob
    dob = Date.parse(session[:registration]['date_of_birth'])
    dob.strftime('%b %d, %Y')
  end

  def show_uk_address
    addr1 = session[:registration]['address_line_1']
    addr2 = session[:registration]['address_line_2']
    city = session[:registration]['town_city']
    postcode = session[:registration]['postcode']
    #do we need these capitalized etc?
    address = [addr1, addr2, city, postcode]
    address.join('<br />').html_safe
  end

  def show_name
    "#{session[:registration]['first_name'].capitalize}" + " " + "#{session[:registration]['last_name'].capitalize}"
  end

  def show_email
    "#{session[:registration]['email_address']}"
  end

  def show_phone
    "#{session[:registration]['telephone_number']}"
  end
end