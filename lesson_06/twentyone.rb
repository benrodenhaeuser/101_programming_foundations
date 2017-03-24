# twenty-one

# USER MESSAGES

require 'yaml'

messages =
  "welcome: Welcome to Twentyone!
please_press_enter: 'Press enter to continue. '
hit_or_stay?: 'Do you want to hit (H) or stay (S)? '
invalid_choice: This is not a valid choice.
players_hand: 'You have: %{player}.'
dealers_partial_hand: 'Dealer has: %{dealer}, and one more card.'
dealers_full_hand: 'Dealer has: %{dealer}.'
players_hands_value_is: 'Your hand is worth %{player}.'
dealers_hands_value_is: 'The hand of dealer is worth %{dealer}.'
dealer_wins: Dealer wins.
player_wins: You win.
its_a_tie: The game is tied.
dealing_flash: ... dealing ...
revealing_flash: ... revealing results ...
player_busted_flash: ... you busted! ...
dealer_busted_flash: ... Dealer busted! ...
player_hitting_flash: ... you are hitting ...
dealer_hitting_flash: ... Dealer is hitting ...
player_busted: You busted!
dealer_busted: Dealer busted!
current_scores_are: Dealer has %{dealer} points, you have %{player} points.
overall_winner_is: The overall winner is %{winner}.
dividing_line: ------------------------------------------------------------
empty_line: ''
another_game?: 'Would you like to play again? (Y/N) '"

MESSAGES = YAML.load(messages)

# CARD STOCK

spades = "\u2660".encode('utf-8')
clubs = "\u2663".encode('utf-8')
hearts = "\u2665".encode('utf-8')
diamonds = "\u2666".encode('utf-8')
suits = [spades, clubs, hearts, diamonds]
numbers = (2..10)
faces = ['jack', 'king', 'queen', 'king']

cards = []
suits.each do |suit|
  numbers.each do |value|
    cards << { name: value.to_s, suit: suit, raw_value: value }
  end

  faces.each do |face|
    cards << { name: face, suit: suit, raw_value: 10 }
  end

  cards << { name: 'ace', suit: suit, raw_value: 11 }
end

CARDS = cards

# GAME MECHANICS

def initialize_game
  game = {
    deck: nil,
    player: [],
    dealer: [],
    winner: nil
  }

  game[:deck] = CARDS.shuffle
  deal_card(:player, game, 2)
  deal_card(:dealer, game, 2)

  game
end

def deal_card(person, game, number_of_cards = 1)
  number_of_cards.times do |_|
    game[person] << game[:deck].pop
  end
end

def initialize_game_scores
  { player: 0, dealer: 0 }
end

def determine_winner(game)
  if busted?(:player, game)
    game[:winner] = :dealer
  elsif busted?(:dealer, game)
    game[:winner] = :player
  elsif value_of(:player, game) > value_of(:dealer, game)
    game[:winner] = :player
  elsif value_of(:player, game) < value_of(:dealer, game)
    game[:winner] = :dealer
  end
end

def hit(person, game)
  deal_card(person, game)
end

def busted?(person, game)
  value_of(person, game) > 21
end

def value_of(person, game)
  if raw_sum(person, game) <= 21
    raw_sum(person, game)
  else
    raw_sum(person, game) - number_of_aces(person, game) * 10
  end
end

def raw_sum(person, game)
  raw_sum = 0
  game[person].each { |card| raw_sum += card[:raw_value] }
  raw_sum
end

def number_of_aces(person, game)
  number_of_aces = 0
  game[person].each do |card|
    if card[:name] == 'ace'
      number_of_aces += 1
    end
  end
  number_of_aces
end

def update(scores, game)
  case game[:winner]
  when :dealer then scores[:dealer] += 1
  when :player then scores[:player] += 1
  end
end

def overall_winner?(scores)
  scores[:player] == 5 || scores[:dealer] == 5
end

# USER INTERFACE

def prompt(message, subst = {}, promptsign = '  ', style = :puts)
  message = MESSAGES[message] % subst
  output = "#{promptsign} #{message}"

  case style
  when :puts then puts output
  when :print then print output
  end
end

def wait_for_user
  prompt('please_press_enter', {}, '=>', :print)
  gets
end

def news_flash(news)
  system 'clear'
  case news
  when :dealing then prompt('dealing_flash')
  when :player_hitting then prompt('player_hitting_flash')
  when :dealer_hitting then prompt('dealer_hitting_flash')
  when :player_busted then prompt('player_busted_flash')
  when :dealer_busted then prompt ('dealer_busted_flash')
  when :revealing then prompt('revealing_flash')
  end
  sleep 0.4
  system 'clear'
end

def display_results(game)
  system 'clear'
  display_hands(game, :reveal)
  display_values(game)
  display_winner(game)
end

def display_hands(game, status)
  players_hand = joinand(get_full_card_names(:player, game))
  dealers_hand = joinand(get_full_card_names(:dealer, game))
  dealers_first_card = get_full_card_names(:dealer, game).first

  prompt('players_hand', { player: players_hand })

  case status
  when :partial
    prompt('dealers_partial_hand', { dealer: dealers_first_card })
  when :reveal
    prompt('dealers_full_hand', { dealer: dealers_hand })
  end

  prompt('dividing_line', {})
end

def get_full_card_names(person, game)
  names = []
  game[person].each do |card|
    names << "#{card[:suit]} #{card[:name].capitalize}"
  end
  names
end

def display_values(game)
  prompt('players_hands_value_is', { player: value_of(:player, game) })
  prompt('dealers_hands_value_is', { dealer: value_of(:dealer, game) })

  if busted?(:dealer, game)
    prompt('dealer_busted')
  elsif busted?(:player, game)
    prompt('player_busted')
  end

  prompt('dividing_line')
end

def display_winner(game)
  if game[:winner] == :dealer
    prompt('dealer_wins', {}, '  ', :print)
  elsif game[:winner] == :player
    prompt('player_wins', {}, '  ', :print)
  else
    prompt('its_a_tie', {}, '  ', :print)
  end
end

def display_scores(scores)
  prompt(
    'current_scores_are',
    {
      player: scores[:player],
      dealer: scores[:dealer]
    },
    '',
    :puts
  )

  prompt('empty_line', {}, '')
end

def display_overall_winner(scores)
  if scores[:player] == 5
    overall_winner = 'you'
  elsif scores[:dealer] == 5
    overall_winner = 'Dealer'
  end

  prompt(
    'overall_winner_is',
    {
      winner: overall_winner
    }
  )

  prompt('empty_line', {}, '')
end

def joinand(array)
  case array.size
  when 0 then ''
  when 1 then array.first
  when 2 then array.join(", and ")
  else
    array[-1] = "and #{array.last}"
    array.join(', ')
  end
end

def user_wants_to_play_again?
  loop do
    prompt('another_game?', {}, '=>', :print)
    answer = gets.chomp
    if answer.upcase == 'Y'
      break true
    elsif answer.upcase == 'N'
      break false
    else
      prompt('invalid_choice')
    end
  end
end

# THE GAME

system 'clear'
prompt('welcome')
wait_for_user

# game loop
loop do
  scores = initialize_game_scores

  # round loop
  loop do
    game = initialize_game
    news_flash(:dealing)
    display_hands(game, :partial)

    # player turn
    loop do
      prompt('hit_or_stay?', {}, '=>', :print)
      decision = gets.chomp
      case decision.upcase
      when 'S' then break
      when 'H'
        hit(:player, game)
        news_flash(:player_hitting)
        break news_flash(:player_busted) if busted?(:player, game)
        display_hands(game, :partial)
      end
      prompt('invalid_choice')
    end

    # dealer turn
    unless busted?(:player, game)
      loop do
        break if value_of(:dealer, game) >= 17
        hit(:dealer, game)
        news_flash(:dealer_hitting)
        break news_flash(:dealer_busted) if busted?(:dealer, game)
      end
    end

    # evaluation + display
    determine_winner(game)
    update(scores, game)
    news_flash(:revealing)
    display_results(game)
    display_scores(scores)

    break display_overall_winner(scores) if overall_winner?(scores)
    wait_for_user
  end

  break unless user_wants_to_play_again?
end