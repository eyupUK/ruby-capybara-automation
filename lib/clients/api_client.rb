require 'httparty'

class ApiClient
  include HTTParty
  base_uri ENV.fetch('BASE_URL', 'https://www.saucedemo.com')

  def get_status
    self.class.get('/status')
  end
end
