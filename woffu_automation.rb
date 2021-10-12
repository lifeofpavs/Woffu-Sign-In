require 'capybara/dsl'
require './user_data'
require './capybara_initialization'

class WoffuSign
  include Capybara::DSL
  include CapybaraInitialization

  def initialize(woffu_url)
    @woffu_url = woffu_url
    @user_data = UserData.new

    read_data

    init_capybara
  rescue 
    return
  end

  def play
    return if @driver.nil? || @username.nil?  || @pwd.nil?

    visit @woffu_url
    sleep(1)
    find('#tuEmail').click.set(@username)
    find('#tuPassword').click.set(@pwd)
    click_button('Entrar')
    sleep(2)
    click_button('Dismiss modal')
    sleep(2)

    within_frame do
      if page.has_css?("#in", wait: 1)
        find("#in").click
        sleep(2)
        puts "Successfully clocked in <3 at #{Time.now}" if page.has_css?("#out", wait: 1)
      else 
        find("#out").click
        sleep(2)
        puts "Successfully signed out <3 at #{Time.now}" if page.has_css?("#in", wait: 1)
      end
    end
  end

  def read_data
    @username, @pwd = read_user_data # Supposing user is the first line and pwd the second

  rescue
    puts "Please, create a .txt file with your username and password and name it 'user_data.txt'"
    puts "Do you want to create it now? [y/n]"
    answer = gets.chomp
    init_user_file_creation if answer == 'y'
    puts "See you around!" 
  end

  def init_user_file_creation
      set_username
      set_password
      save_user_data
      raise StandardError
  end

  def method_missing(name, *args)
    super unless @user_data.respond_to?(name)

    @user_data.send(name, *args)
  end
end
