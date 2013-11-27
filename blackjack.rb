deck = []
def populate_deck(deck)
    
    n = 2
    while(n <= 9) do 
    
        4.times do
            deck << n.to_s
        end
        n+= 1
    end 
    
    4.times do
        deck << 'A'
        deck << 'J'
        deck << 'Q'
        deck << 'K'
    end
end

populate_deck(deck)
user_hand = []

def populate_user(user_hand, deck)
   
    2.times do
            user_hand << deck.delete_at(rand(deck.length))
    end
end

populate_user(user_hand, deck)

deck.shuffle!
puts "User hand: "
print user_hand
puts 

while(true) do

    #convert user_hand to aces last hack
    #I thought this up myself I'm so smart.
    user_hand.sort!{|x,y| x.ord <=> y.ord}

    puts user_hand

    puts "Hit, Stay, or Abort"
    user_input = gets.chomp

    case user_input
    when "hit"

    when "stay"

    when "abort"

    else
        puts "Incorrect input"
    end
end
