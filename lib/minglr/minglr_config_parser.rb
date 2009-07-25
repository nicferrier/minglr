class MinglrConfigParser
  CONFIG_FILE = ".minglrconfig"
  attr_reader :config
  
  def self.parse
    config_files = [File.join(ENV["HOME"], CONFIG_FILE), File.join(ENV["PWD"], CONFIG_FILE)]
    config_files.each do |config_file_name|
      if File.exist?(config_file_name)
        return self.new(File.read(config_file_name)).config
      end
    end
    puts "Unable to find #{CONFIG_FILE} in #{config_files.join(", ")}"
  end
  
  def initialize(config_contents)
    @config = {}
    @current_section = nil
    config_contents.each_line do |line|
      line = line.strip!
      case line
      when "", /^#.*$/
        next
      when /\[(.*)\]/
        define_section($1.to_s)
      else
        define_var(line)
      end
    end
    @config
  end
  
  def define_section(section_name)
    @config[section_name.to_sym] = {} unless @config.has_key?(section_name.to_sym)
    @current_section = section_name.to_sym
  end
  
  def define_var(line)
    key, value = line.split("=")
    key.strip!
    value.strip!
    @config[@current_section][key.to_sym] = value
  end
  
end