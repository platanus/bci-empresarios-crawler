class Login < Crabfarm::BaseNavigator
  include NavigatorHelper

  def run
    browser.goto 'https://www.bci.cl/empresarios/'

    login_menu_link.click
    login_form_link
    sleep(0.5)
    login_form_link.click
    fill_login_form
    wait_until_correct_access
    {}
  end

  def login_menu_link
    wait_until_present browser.div(id: 'nav-menu').link(class: 'entry-account')
  end

  def login_form_link
    wait_until_present browser.div(id: 'container-login').link(class: 'btn-primary')
  end

  def fill_login_form
    form = browser.form(id: 'frm').when_present

    form.text_field(:name, 'rut_aux').set params[:rut]
    form.text_field(:name, 'clave').set params[:password]
    form.button(:value, 'Ingresar').click
  end

  def wait_until_correct_access
    browser.div(:id => 'central').wait_until_present
  end
end
