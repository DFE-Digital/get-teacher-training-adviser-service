module SessionHelper
  def show_session(question)
    session[:registration][question] ? session[:registration][question].capitalize : nil
  end 

  def show_link(href)
    "<a href='#{href}'>Change</a>".html_safe
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

  def show_overseas_callback
    phone = session[:registration]['telephone']
    date = session[:registration]['callback_date']
    time = session[:registration]['callback_time']
    
    
  end

end