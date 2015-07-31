module NavigatorHelper
  def click_on_option_menu(step_texts)
    step_texts[0...-1].each do |text|
      menu_item = menu_izquierdo.span(:text => text)
      menu_item.click if menu_item.parent.class_name.include?('expandable')
    end

    menu_izquierdo.link(:text => step_texts.last).click
  end

  def menu_izquierdo
    browser.div(:id => 'menu_secciones')
  end

  def iframe_contenido
    wait_until_present browser.iframe(:id => 'iframeContenido')
  end

  def wait_until_present(element)
    sleep(0.3)
    element.wait_until_present
    element
  end

  def visa_card_select
    wait_until_present iframe_contenido.select_list(:id => 'formMovimientos:select_mostrar')
  end

  def choose_visa_card(type)
    visa_card_select.select_value(type)
  end
end
