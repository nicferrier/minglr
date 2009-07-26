class MinglrAction
  
  # TODO
  ACTIONS = ["projects", "cards", "card", "create", "update", "move", "users", "attach", "fetch"].sort!
  
  def self.execute(action, options = [], flag_options = {}, config = {})
    MinglrAction.new(action.to_sym, options, flag_options, config)
  end
  
  attr_reader :action, :options, :flag_options, :config
  
  def initialize(action, options, flag_options, config)
    @action = action
    if action == options[0].to_sym
      options.shift
    else
      options.shift
      options.shift
    end
    @options = options
    @flag_options = flag_options
    @config = config
    begin
      self.send(action)
    rescue ActiveResource::ResourceNotFound => error
      puts error.message + " for URL #{Resources::Base.site}..."
    end
  end
  
  def attach
    card_number = @options.first
    file_name = @flag_options[:file_attachment]
    Resources::Attachment.attach(card_number, file_name, @config[:username], @config[:password])
  end

  def card
    Resources::Card.print_card(@options.first, @config[:status_property])
  end
  
  def cards
    Resources::Card.print_all(@options, @config[:status_property])
  end
  
  def create
    Resources::Card.create(@flag_options, @config[:status_property])
  end
  
  def fetch
    card_number = @options.first
    Resources::Attachment.fetch(card_number, @config[:username], @config[:password])
  end
  
  def move
    card_number = @options.first
    Resources::Card.move(card_number, @flag_options, @config)
  end
  
  def projects
    Resources::Project.print_all(@options, @config[:status_property])
  end
  
  def update
    card_number = @options.first
    Resources::Card.update(card_number, @flag_options)
  end
  
  def users
    Resources::User.print_all(@options)
  end

end