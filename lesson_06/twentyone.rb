# twenty-one

# CONFIGURATION

NUMBER_OF_ROUND_WINS_TO_WIN = 5
DEALER_STAY_VALUE = 17
BUST_VALUE = 21

# USER MESSAGES

require 'yaml'

messages =
  "welcome: Welcome to Twentyone!
please_press_enter: 'Press enter to continue. '
hit_or_stay?: 'Do you want to hit (H) or stay (S)? '
invalid_choice: This is not a valid choice.
players_hand: 'You have: %{player}.'
dealers_first_card: 'Dealer has: %{dealer}, and one more card.'
dealers_full_hand: 'Dealer has: %{dealer}.'
players_hands_value_is: 'Your hand is worth %{player}.'
dealers_hands_value_is: 'The hand of dealer is worth %{dealer}.'
dealer_wins: Dealer wins.
player_wins: You win.
its_a_tie: The game is tied.
dealing: ... dealing ...
revealing: ... revealing results ...
player_busting: ... you busted! ...
dealer_busting: ... Dealer busted! ...
player_hitting: ... you are hitting ...
dealer_hitting: ... Dealer is hitting ...
player_busted: You busted!
dealer_busted: Dealer busted!
current_scores_are: Dealer has %{dealer} points, you have %{player} points.
overall_winner_is: We have an overall winner. It's %{winner}.
dividing_line: ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
empty_line: ''
another_game?: 'Would you like to play again? (Y/N) '
bye: Good-Bye!"

MESSAGES = YAML.load(messages)

# CARD STOCK

spades = "\u2660".encode('utf-8')
clubs = "\u2663".encode('utf-8')
hearts = "\u2665".encode('utf-8')
diamonds = "\u2666".encode('utf-8')
suits = [spades, clubs, hearts, diamonds]
numbers = (2..10)
faces = ['jack', 'queen', 'king']

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
    deck: CARDS.shuffle,
    player: [],
    dealer: [],
    winner: nil
  }

  deal_card(:player, game, 2)
  deal_card(:dealer, game, 2)

  game
end

def deal_card(hand, game, number_of_cards = 1)
  number_of_cards.times do |_|
    game[hand] << game[:deck].pop
  end
end

def hit(hand, game)
  deal_card(hand, game)
end

def update_with_winner(game)
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

def busted?(hand, game)
  value_of(hand, game) > BUST_VALUE
end

def value_of(hand, game)
  if raw_sum(hand, game) <= BUST_VALUE
    raw_sum(hand, game)
  else
    raw_sum(hand, game) - number_of_aces(hand, game) * 10
  end
end

def raw_sum(hand, game)
  raw_sum = 0
  game[hand].each { |card| raw_sum += card[:raw_value] }
  raw_sum
end

def number_of_aces(hand, game)
  number_of_aces = 0
  game[hand].each do |card|
    if card[:name] == 'ace'
      number_of_aces += 1
    end
  end
  number_of_aces
end

def initialize_game_scores
  { player: 0, dealer: 0 }
end

def update(scores, game)
  case game[:winner]
  when :dealer then scores[:dealer] += 1
  when :player then scores[:player] += 1
  end
end

def overall_winner?(scores)
  scores[:player] == NUMBER_OF_ROUND_WINS_TO_WIN ||
    scores[:dealer] == NUMBER_OF_ROUND_WINS_TO_WIN
end

# USER INTERFACE

def prompt(message, subst = {}, promptsymbol = '  ', linebreak = true)
  message = MESSAGES[message] % subst
  output = "#{promptsymbol} #{message}"

  if linebreak
    puts output
  else
    print output
  end
end

def news_flash(news)
  system 'clear'
  prompt(news)
  sleep 0.4
  system 'clear'
end

def wait_for_user
  prompt('please_press_enter', {}, '=>', false)
  gets
end

def display_hands(game, transparency)
  players_hand = joinand(get_card_list(:player, game))
  prompt('players_hand', { player: players_hand })

  case transparency
  when :partial
    dealers_first_card = get_card_list(:dealer, game).first
    prompt('dealers_first_card', { dealer: dealers_first_card })
  when :full
    dealers_full_hand = joinand(get_card_list(:dealer, game))
    prompt('dealers_full_hand', { dealer: dealers_full_hand })
  end

  prompt('dividing_line', {})

  show_values(game, transparency)
end

def show_values(game, transparency)
  prompt('players_hands_value_is', { player: value_of(:player, game) })

  if transparency == :full
    prompt('dealers_hands_value_is', { dealer: value_of(:dealer, game) })
  end

  prompt('dividing_line')
end

def get_card_list(hand, game)
  names = []
  game[hand].each do |card|
    names << "#{card[:suit]} #{card[:name].capitalize}"
  end
  names
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

def display_winner(game)
  if busted?(:dealer, game)
    prompt('dealer_busted')
  elsif busted?(:player, game)
    prompt('player_busted')
  end

  if game[:winner] == :dealer
    prompt('dealer_wins')
  elsif game[:winner] == :player
    prompt('player_wins')
  else
    prompt('its_a_tie')
  end

  prompt('dividing_line')
end

def display_scores(scores)
  prompt(
    'current_scores_are',
    {
      player: scores[:player],
      dealer: scores[:dealer]
    }
  )

  prompt('empty_line', {}, '')
end

def display_overall_winner(scores)
  if scores[:player] == NUMBER_OF_ROUND_WINS_TO_WIN
    overall_winner = 'you'
  elsif scores[:dealer] == NUMBER_OF_ROUND_WINS_TO_WIN
    overall_winner = 'Dealer'
  end

  prompt(
    'overall_winner_is',
    {
      winner: overall_winner
    }
  )

  prompt('empty_line')
end

def user_wants_to_play_again?
  loop do
    prompt('another_game?', {}, '=>', false)
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

# main loop
loop do
  scores = initialize_game_scores

  # round loop
  loop do
    game = initialize_game
    news_flash('dealing')
    display_hands(game, :partial)

    # player turn
    loop do
      prompt('hit_or_stay?', {}, '=>', false)
      decision = gets.chomp
      case decision.upcase
      when 'S' then break
      when 'H'
        hit(:player, game)
        news_flash('player_hitting')
        break news_flash('player_busting') if busted?(:player, game)
        display_hands(game, :partial)
      else
        prompt('invalid_choice')
      end
    end

    # dealer turn
    unless busted?(:player, game)
      loop do
        break if value_of(:dealer, game) >= DEALER_STAY_VALUE
        hit(:dealer, game)
        news_flash('dealer_hitting')
        break news_flash('dealer_busting') if busted?(:dealer, game)
      end
    end

    # evaluation
    update_with_winner(game)
    update(scores, game)
    news_flash('revealing')
    display_hands(game, :full)
    display_winner(game)
    display_scores(scores)

    break display_overall_winner(scores) if overall_winner?(scores)
    wait_for_user
  end

  break prompt('bye') unless user_wants_to_play_again?
end
