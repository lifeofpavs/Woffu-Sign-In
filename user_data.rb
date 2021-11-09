class UserData
  FILE_NAME = 'user_data.txt'.freeze
  DATA_ATTRIBUTES = [:username, :password].freeze

  def initialize;  end

  def self.initialize_setters(attributes)
    attributes.each do |attr|
      define_method "set_#{attr}" do 
        value = ""
        while value.empty? do
          puts "Please, input your #{attr}"
          value = gets.chomp
          puts "Sorry, I did not quite get that :/" if value.empty?
        end

        instance_variable_set("@#{attr}", value)
      end
    end
  end

  def save_user_data
    file = File.open(FILE_NAME, 'w') do |f|
      DATA_ATTRIBUTES.each do |attribute|
        f.write("#{Base64.encode64(instance_variable_get("@#{attribute}"))}")
        
      end
    end
    puts "The file #{FILE_NAME} has been successfully created"
  end

  def read_user_data
    return read_user_data_from_file if File.exists?(FILE_NAME)

    [ENV['username'], ENV['password']]
  end

  def read_user_data_from_file
    username, password = File.open(FILE_NAME).readlines.map(&:chomp)
    
    [Base64.decode64(username), Base64.decode64(password)]
  end

  initialize_setters DATA_ATTRIBUTES

end