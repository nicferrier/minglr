class MinglrAction
  
  ACTIONS = ["cards", "card", "create", "update", "move", "users", "attach", "fetch"].sort!
  
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
      puts error.message + " for URL #{MingleResource.site}..."
    end
  end
  
  def cards
    attributes = [:number, :card_type_name, @config[:status_property].to_sym, :name]
    cards = Resources::Card.find(:all)
    cards = filter_collection(cards, attributes, @options)
    print_collection(cards, attributes)
  end

  def users
    attributes = [:login, :name, :email]
    users = Resources::User.find(:all).collect! { |user| user.user }
    users = filter_collection(users, attributes, @options)
    print_collection(users, attributes, "right")
  end

  def card
    card_number = @options.first
    attributes = [:number, :card_type_name, @config[:status_property].to_sym, :name, :description]
    card = card_by_number(card_number)
    attachments = Resources::Attachment.find(:all, :params => { :card_number => card_number })
    attachments = attachments.collect do |attachment|
      "* #{attachment.file_name}: #{MingleResource.site + attachment.url}"
    end
    output = <<-EOS
     Number: #{card.number}
       Name: #{card.name}
       Type: #{card.card_type_name}
     Status: #{card.send(@config[:status_property].to_sym)}
Description: #{card.description}

Attachments:
  #{attachments.join("\n")}
    EOS
    puts output
  end
  
  def attach
    card_number = @options.first
    if card_to_update = card_by_number(card_number)
      url = Resources::Attachment.site
      url = (url.to_s.gsub(/#{url.path}$/, '')) + Resources::Attachment.collection_path(:card_number => card_number)
      file_name = @flag_options[:file_attachment]
      require 'httpclient'
      if File.exist?(file_name)
        File.open(file_name) do |file|
          body = { 'file' => file, "filename" => file_name }
          client = HTTPClient.new
          client.set_auth(nil, @config[:username], @config[:password])
          res = client.post(url, body)
          if res.status_code == 201
            puts "File '#{file_name}' attached to card #{card_number}"
          else
            puts "Error attaching file '#{file_name}' to card #{card_number} (Got back HTTP code #{res.status_code})"
          end
        end
      else
        puts "Unable to open file '#{file_name}'"
      end
    end
  end
  
  def fetch
    card_number = @options.first
    if card_to_update = card_by_number(card_number)
      attachments = Resources::Attachment.find(:all, :params => { :card_number => card_number })
      attachments.each do |attachment|
        url = MingleResource.site + attachment.url
        url.userinfo = nil, nil
        puts "Downloading #{url.to_s}:"
        `curl --insecure --progress-bar --output #{attachment.file_name} --user #{@config[:username]}:#{@config[:password]} #{url}`
      end
    end
  end
  
  def create
    @flag_options.merge!({ @config[:status_property].to_sym => "New", :cp_owner_user_id => owner_id })
    card = Resources::Card.new(@flag_options)
    card.save
    card.reload
    puts "Card #{card.number} created"
  end
  
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
  
  def move
    card_number = @options.first
    card_to_move = card_by_number(card_number)
    transition_options = { :card => card_number }
    transition_options.merge!({ :comment => @flag_options[:comment]}) if @flag_options[:comment]
    current_status = card_to_move.send(@config[:status_property])
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
  
  def pickup
    raise "not implemented yet"
  end
  
  private
  
  def filter_collection(collection, attributes, words)
    words.each do |word|
      collection = collection.select do |element|
        output = ""
        attributes.each { |attribute| output << element.send(attribute).to_s + " " }
        output =~ /#{word}/i
      end
    end
    collection
  end
  
  def print_collection(collection, attributes, align = "left")
    output = []
    longest_attributes = Array.new(attributes.length, 0)
    alignment = (align == "left" ? :ljust : :rjust)
    collection.each do |element|
      entry = []
      attributes.each_with_index do |attribute, index|
        attribute_value = element.send(attribute).to_s
        longest_attributes[index] = attribute_value.length if attribute_value.length > longest_attributes[index]
        entry << attribute_value
      end
      output << entry
    end
    output.each do |entry|
      row = []
      entry.each_with_index do |part, index|
        row << [part.send(alignment, longest_attributes[index])]
      end
      puts row.join(" - ")
    end
  end
  
  def card_by_number(number)
    Resources::Card.find(number)
  end
  
  def owner_id
    user = Resources::User.find(:all).select { |user| user.user.login == @config[:username] }.first
    user.user_id
  end
  
end