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
      options.shift; options.shift
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
  
  # TODO
  def create
    @flag_options.merge!({ @config[:status_property].to_sym => "New", :cp_owner_user_id => owner_id })
    card = Resources::Card.new(@flag_options)
    card.save
    card.reload
    puts "Card #{card.number} created"
  end
  
  def fetch
    card_number = @options.first
    Resources::Attachment.fetch(card_number, @config[:username], @config[:password])
  end
  
  # TODO
  def move
    card_number = @options.first
    card_to_move = card_by_number(card_number)
    transition_options = { :card => card_number }
    transition_options.merge!({ :comment => @flag_options[:comment]}) if @flag_options[:comment]
    current_status = card_to_move.send(@config[:status_property]) if status_property
    next_transition = nil
    
    case card_to_move.card_type_name.downcase
    when /task/
      status_states = @config.select do |key, value|
        key.to_s =~ /^task_state_/
      end
    when /story/
      status_states = @config.select do |key, value|
        key.to_s =~ /^story_state/
      end
    else
      puts "No transitions defined for card of type #{card_to_move.card_type_name}"  
    end
    status_states = status_states.collect {|state| state.last }.collect {|state| state.split(">").collect { |value| value.strip } }
    next_transition = status_states.select {|state| state.first.downcase == current_status.downcase }.first.last
    transition_options.merge!({ :transition => next_transition })

    if response = Resources::TransitionExecution.create(transition_options)
      if response.attributes["status"] == "completed"
        puts "Moved card from #{current_status} to #{next_transition}"
      end
    end
  end
  
  # TODO
  def pickup
    raise "not implemented yet"
  end
  
  def projects
    Resources::Project.print_all(@options, @config[:status_property])
  end
  
  # TODO
  def update
    @flag_options.merge!({ :cp_owner_user_id => owner_id })
    card_number = @options.first
    card_to_update = card_by_number(card_number)
    @flag_options.each do |attribute, value|
      card_to_update.send("#{attribute.to_s}=".to_sym, value)
    end
    card_to_update.save
    puts "Card #{card_to_update.number} updated\n\n"
    card
  end
  
  def users
    Resources::User.print_all(@options)
  end
  
  private
  
  # TODO
  def status_property
    @config[:status_property].nil? ? nil : @config[:status_property].to_sym
  end
  
  # TODO
  def card_by_number(number)
    Resources::Card.find(number)
  end

  # TODO  
  def owner_id
    Resources::User.find_user_id_for_user(@config[:username])
  end
  
end