deck = []
def populate_deck(deck)
    
    n = 0
    while(n <= 9) do 
    
        4.times do
            deck << n.to_str
        end
        n+= 1
    end 
    
    4.times do
        deck << "A"
        deck << "J"
        deck << "Q"
        deck << "K"
    end
end

populate_deck(deck)
user_hand = []
populate_user(user_hand)
while(true) do

    puts "Play a game of BlackJack"
    
    user_hand = []
    2.times do
        user_hand << deck.delete_at(rand(deck.length))
    end
    hand_value = 0
    
    #Sorting hack to get aces at the very end
    user_hand.sort_by { |c| c.to_i != 0 ? c : c[0] - 81 }.reverse().inject(0) do |total,cur|

    user_hand.each do |x|
        if x.is_a Integer
            hand_value+= x
        elsif x == ['J', 'Q', 'K'].include? x
            hand_value+= 10
        elsif x == 'A'
            if( hand_value+11) > 21
                hand_value+= 1
            else
                hand_value+= 11
            end
        end
    end


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


