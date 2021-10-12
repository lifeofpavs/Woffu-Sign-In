require 'capybara'
require 'selenium-webdriver'

module CapybaraInitialization
  def init_capybara
    # Initialized the web driver
    @driver = Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options )
    end

    Capybara.default_max_wait_time = 5
    Capybara.run_server = false
    Capybara.current_driver = :chrome
  end

  def chrome_options
    opts = Selenium::WebDriver::Chrome::Options.new
    opts.add_argument('--headless') unless ENV['UI']
    opts.add_argument('--no-sandbox')
    opts.add_argument('--disable-gpu')
    opts.add_argument('--disable-dev-shm-usage')
    opts.add_argument('--window-size=1400,1400')

    opts
  end
end