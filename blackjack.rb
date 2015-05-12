DECK_VALS = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King" ]
SUITS = ["Spade", "Hart", "Diamond", "Club"]

def draw(deck)
  deck.pop()
end

def get_value(card)
  val = card[:value]
  case val
  when "2".."10"
    num = val.to_i
  when "Jack", "Queen", "King"
    num = 10
  else
    num = 11
  end
  num
end

def total(deck)
  aces = 0
  sum = 0
  deck.each do | card |
    val = get_value(card)
    if val == 11
      aces += 1
    end
    sum += val
  end
  while (sum > 21 && aces > 0)
    sum -= 10
  end
  sum
end

def make_deck()
  deck = []
  for val in DECK_VALS
    for suit in SUITS
      card = {}
      card[:suit] = suit
      card[:value] = val
      deck.push(card)
    end
  end
  deck
end

def shuffle(deck)
  for i in 1..(deck.length) * 3
    deck.push(deck.delete_at(rand(0..deck.length - 1)))
  end
end

# no validation; get no empty name at least
def get_name()
  puts "Please enter your name"
  name = gets.chomp
  return(name)
end

def display_hand(hand)
  hand.each do | card |
    puts "#{card[:suit]}:#{card[:value]}"
  end
  puts "total: #{total(hand)}"
  puts "-------------------"
end

name = get_name()
puts "Hi, #{name}, let play."

loop do
  deck = make_deck()
  shuffle(deck)
  player = []
  dealer = []
  player_total = 0
  dealer_total = 0
  game_over = false
  player.push(draw(deck))
  player.push(draw(deck))
  dealer.push(draw(deck))
  dealer.push(draw(deck))
  display_hand(player)
  loop do
    player_total = total(player)
    if player_total > 21
      puts "you lost."
      game_over = true
      break
    elsif
      player_total == 21
      puts "you win."
      game_over = true
      break
    else
      puts "would you like to hit or stay? (h/s)"
      if gets.chomp.downcase == "h"
        player.push(draw(deck))
        display_hand(player)
      else
        break
      end
    end
  end

  if !game_over
    puts "dealer's hand:"
    loop do
      display_hand(dealer)
      dealer_total = total(dealer)
      if dealer_total == 21
        puts "you lost."
        break
      elsif dealer_total < 17
        dealer.push(draw(deck))
      elsif dealer_total > 21
        puts "you win."
        break
      elsif dealer_total > player_total
        puts "you lost."
        break  
      elsif dealer_total == player_total
        puts "tie."
        break
      else
        dealer.push(draw(deck))
      end
    end
  end
  
  puts "#{name}, would you like to play again? (y/n)"
  if gets.chomp.downcase == "n"
    break
  end
end
