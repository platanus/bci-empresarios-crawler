class Login < Crabfarm::BaseNavigator

  def run
    browser.goto 'http://www.bci.cl/empresarios/'

    go_to_login_form
    fill_login_form
    wait_until_correct_access

    {}
  end

  def go_to_login_form
    browser.div(:id => 'bancoenlinea').link.click
  end

  def fill_login_form
    iframe = browser.iframe(:src => 'https://bciimg.bci.cl/sitioseguro/loginempresarios_act.html').when_present

    iframe.text_field(:name, 'rut_aux').set params[:rut]
    iframe.text_field(:name, 'clave_aux').set params[:password]
    iframe.button(:value, 'Ingresar').click
  end

  def wait_until_correct_access
    browser.div(:id => 'central').wait_until_present
  end
end
