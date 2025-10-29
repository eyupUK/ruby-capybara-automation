class LoginPage < SitePrism::Page
  set_url '/'

  element :username, '#user-name'
  element :password, '#password'
  element :login_button, '#login-button'
  element :error_message, '[data-test="error"]'
  
  # Elements for handling password change modal
  element :ok_button, 'button', text: 'OK'
  element :close_x_button, '*', text: '×'
  element :modal_container, '[role="dialog"], .modal, .dialog'

  def login_as(user, pass)
    username.set(user)
    password.set(pass)
    login_button.click
  end
  
  def dismiss_password_modal
    if has_content?('Change your password', wait: 2)
      if has_ok_button?
        ok_button.click
      elsif has_close_x_button?
        close_x_button.click
      else
        # Try pressing Escape as fallback
        page.driver.browser.action.send_keys(:escape).perform
      end
      
      # Wait for modal to disappear
      has_no_content?('Change your password', wait: 5)
    end
  end
end
