class MinglrOptionsParser
  def self.parse(args, *required_by_command)
    uri_options = {}
    command_options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: minglr [action] [options]"
      opts.separator ""
      opts.separator "Valid Commands Are: #{MinglrAction::ACTIONS.join(", ")}"
      
      opts.on("-n NAME", String, "Short name of card") do |card_name|
        command_options[:name] = card_name
      end
      
      opts.on("-d DESCRIPTION", String, "Description of card") do |card_description|
        command_options[:description] = card_description
      end
      
      opts.on("-t TYPE", String, "Type of card") do |card_type|
        command_options[:card_type_name] = card_type
      end
      
      opts.on("-c COMMENT", String, "Comment") do |comment|
        command_options[:comment] = comment
      end

      opts.on_tail("-h", "--help", "Show this help message.") do |help|
        puts opts
        exit
      end
      
      
      
      opts.on_tail("--version", "Show version") do
        puts Minglr::VERSION
        exit
      end
      
      if args.empty?
        puts opts
        exit
      end
    end

    parser.parse! args
    command_options
  end
end