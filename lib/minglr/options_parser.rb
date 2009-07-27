require "yaml"

module Minglr
  class OptionsParser
    def self.parse(args, *required_by_command)
      project_options = []
    
      if Resources::Base.site
        begin
          project_options = Resources::PropertyDefinition.project_options
        rescue ActiveResource::UnauthorizedAccess => exception
          puts "Connection #{exception.message} to #{Resources::Base.site.to_s}"
          puts "Did you set 'basic_authentication_enabled: true' in your auth_config.yml file?"
          exit 1 unless MINGLR_ENV == "test"
        end
      end
      
      command_options = {}
      
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: minglr [action] [options]"
        opts.separator ""
        opts.separator "Valid Commands Are: #{Minglr::Action.valid_actions.join(", ")}"
      
        opts.on("-n NAME", String, "Short name of card") do |card_name|
          command_options[:name] = card_name.strip
        end
      
        opts.on("-d DESCRIPTION", String, "Description of card") do |card_description|
          command_options[:description] = card_description.strip
        end
      
        opts.on("-t TYPE", String, "Type of card") do |card_type|
          command_options[:card_type_name] = card_type.strip
        end
      
        opts.on("-c COMMENT", String, "Comment") do |comment|
          command_options[:comment] = comment.strip
        end
      
        opts.on("-f FILE", String, "File to attach") do |file|
          command_options[:file_attachment] = file.strip
        end
      
        unless project_options.empty?
          opts.separator ""
          opts.separator "Project Specific Options"
        
          project_options.each do |option_pair|
            option_switch = option_pair[1].downcase.gsub(/\s|_/, "-").gsub(/--|---/, '-').gsub(/--/, '-')
            opts.on("--#{option_switch}", String, "Set the #{option_pair[1]} for a card") do |option|
              command_options[option_pair[0]] = option
            end
          end
        
          opts.separator ""
        end
    
        opts.on_tail("-h", "--help", "Show this help message.") do |help|
          puts opts
          exit 0 unless MINGLR_ENV == "test"
        end
      
        opts.on_tail("--version", "Show version") do
          version = YAML.load(File.read(File.join(File.dirname(__FILE__), "..", "..", "VERSION.yml")))
          puts "#{version[:major]}.#{version[:minor]}.#{version[:patch]}"
          exit 0 unless MINGLR_ENV == "test"
        end
      
        if args.empty?
          puts opts
          exit 0 unless MINGLR_ENV == "test"
        end
      end

      parser.parse! args
      command_options
    end
    
  end

end