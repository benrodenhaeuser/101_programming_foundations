# twenty-one

# CONFIGURATION

NUMBER_OF_ROUND_WINS_TO_WIN = 5
DEALER_STAY = 17
BUST = 21

# USER MESSAGES

MESSAGES = {
  'welcome' => 'Welcome to Twentyone!',
  'please_press_enter' => 'Press enter to continue. ',
  'hit_or_stay?' => 'Do you want to hit (H) or stay (S)? ',
  'invalid_choice' => 'This is not a valid choice.',
  'players_hand' => "You have: %{player}.",
  'dealers_first_card' => "Dealer has: %{dealer}, and one more card.",
  'dealers_full_hand' => "Dealer has: %{dealer}.",
  'players_hands_value_is' => "Your hand is worth %{player}.",
  'dealers_hands_value_is' => "The hand of dealer is worth %{dealer}.",
  'dealer_wins' => 'Dealer wins.',
  'player_wins' => 'You win.',
  'its_a_tie' => 'The game is tied.',
  'dealing' => '... dealing ...',
  'revealing' => '... revealing results ...',
  'player_busting' => '... you busted! ...',
  'dealer_busting' => '... Dealer busted! ...',
  'player_hitting' => '... you are hitting ...',
  'dealer_hitting' => '... Dealer is hitting ...',
  'player_busted' => 'You busted!',
  'dealer_busted' => 'Dealer busted!',
  'current_scores_are' => "Dealer: %{dealer} points. You: %{player} points.",
  'overall_winner_is' => "We have an overall winner: %{winner}.",
  'dividing_line' => '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~',
  'empty_line' => '',
  'another_game?' => 'Would you like to play again? (Y/N) ',
  'bye' => 'Good-Bye!'
}

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

# GAME LOOP

def start
  system 'clear'
  prompt('welcome')
  wait_for_user

  loop do
    scores = initialize_game_scores
    play_game(scores)
    break prompt('bye') unless user_wants_to_play_again?
  end
end

def play_game(scores)
  loop do
    game = initialize_game
    news_flash('dealing')
    display_hands(game, :partial)

    player_turn(game)
    dealer_turn(game)
    evaluate_game(game, scores)

    if overall_winner?(scores)
      break display_overall_winner(scores)
    else
      wait_for_user
    end
  end
end

def player_turn(game)
  loop do
    decision = hit_or_stay
    case decision
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
end

def dealer_turn(game)
  unless busted?(:player, game)
    loop do
      break if value_of_hand(:dealer, game) >= DEALER_STAY
      hit(:dealer, game)
      news_flash('dealer_hitting')
      break news_flash('dealer_busting') if busted?(:dealer, game)
    end
  end
end

def evaluate_game(game, scores)
  set_winner(game, determine_winner(game))
  update_scores(scores, game)
  news_flash('revealing')
  display_hands(game, :full)
  display_winner(game)
  display_scores(scores)
end

def user_wants_to_play_again?
  loop do
    prompt('another_game?', prompt_symbol: '=>', line_break: false)
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

# INTERNAL GAME MECHANICS

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

def deal_card(person, game, number_of_cards = 1)
  number_of_cards.times do
    game[person] << game[:deck].pop
  end
end

def hit(person, game)
  deal_card(person, game)
end

def determine_winner(game)
  if busted?(:player, game)
    :dealer
  elsif busted?(:dealer, game)
    :player
  elsif value_of_hand(:player, game) > value_of_hand(:dealer, game)
    :player
  elsif value_of_hand(:player, game) < value_of_hand(:dealer, game)
    :dealer
  end
end

def set_winner(game, winner)
  game[:winner] = winner
end

def busted?(person, game)
  value_of_hand(person, game) > BUST
end

def value_of_hand(person, game)
  value = raw_sum_of_hand(person, game)
  number_of_aces(person, game).times { value -= 10 if value > BUST }
  value
end

def raw_sum_of_hand(person, game)
  game[person].inject(0) { |raw_sum, card| raw_sum + card[:raw_value] }
end

def number_of_aces(person, game)
  game[person].count { |card| card[:name] == 'ace' }
end

def initialize_game_scores
  { player: 0, dealer: 0 }
end

def update_scores(scores, game)
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

def prompt(message, substitution: {}, prompt_symbol: '  ', line_break: true)
  message = MESSAGES[message] % substitution
  output = "#{prompt_symbol} #{message}"

  if line_break
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
  prompt('please_press_enter', prompt_symbol: '=>', line_break: false)
  gets
end

def hit_or_stay
  prompt('hit_or_stay?', prompt_symbol: '=>', line_break: false)
  gets.chomp.upcase
end

def display_hands(game, transparency)
  players_hand = joinand(get_card_list(:player, game))
  prompt('players_hand', substitution: { player: players_hand })

  case transparency
  when :partial
    dealers_first_card = get_card_list(:dealer, game).first
    prompt('dealers_first_card', substitution: { dealer: dealers_first_card })
  when :full
    dealers_full_hand = joinand(get_card_list(:dealer, game))
    prompt('dealers_full_hand', substitution: { dealer: dealers_full_hand })
  end

  prompt('dividing_line')

  show_values(game, transparency)
end

def show_values(game, transparency)
  prompt(
    'players_hands_value_is',
    substitution: { player: value_of_hand(:player, game) }
  )

  if transparency == :full
    prompt(
      'dealers_hands_value_is',
      substitution: { dealer: value_of_hand(:dealer, game) }
    )
  end

  prompt('dividing_line')
end

def get_card_list(person, game)
  game[person].map { |card| "#{card[:suit]} #{card[:name].capitalize}" }
end

def joinand(array)
  case array.size
  when 0 then ''
  when 1 then array.first
  when 2 then array.join(', and ')
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
    substitution: { player: scores[:player], dealer: scores[:dealer] }
  )

  prompt('empty_line', prompt_symbol: '')
end

def display_overall_winner(scores)
  if scores[:player] == NUMBER_OF_ROUND_WINS_TO_WIN
    overall_winner = 'You'
  elsif scores[:dealer] == NUMBER_OF_ROUND_WINS_TO_WIN
    overall_winner = 'Dealer'
  end

  prompt('overall_winner_is', substitution: { winner: overall_winner })

  prompt('empty_line')
end

# KICK IT OFF ...

start
