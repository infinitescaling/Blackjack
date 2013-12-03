def initialize(user_hand, deck, dealer_hand)
    deck = populate_deck(deck)
    user_hand = populate_user(user_hand, deck)
    dealer_hand = populate_dealer(dealer_hand, deck)
    puts "Game is initialized"
end

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

    deck.shuffle!
        return deck
end

def populate_user(user_hand, deck)
   
    2.times do
            user_hand << deck.delete_at(rand(deck.length))
    end
    return user_hand
end

def calculate_value(hand)
    hand_value = 0

    hand.each do |x|
        if ['2','3','4','5','6','7','8','9'].include? x
            hand_value+= x.to_i
        elsif ['J', 'Q', 'K'].include? x
            hand_value =  hand_value + 10
        elsif x == "A"
            if(hand_value + 11) > 21
                hand_value+= 1
            else
                hand_value+= 11
            end
        end
    end

    return hand_value
end

def populate_dealer(dealer_hand, deck)
    2.times do
        dealer_hand << deck.delete_at(rand(deck.length))
    end
    return dealer_hand
end

def gameover
    puts "Play again? Y/N"
        user_input = gets.chomp!
        user_input.upcase!
        while(true)
            case user_input
                when "Y"
                    return 1
                when "N"
                    abort("Thank you for playing")
                else
                    puts "Incorrect input"
                end
        end
end
#start game
deck = []
user_hand = []
dealer_hand = []
initialize(user_hand, deck, dealer_hand)

while(true) do

    #convert user_hand to aces last hack
    #I thought this up myself I'm so smart.
    user_hand.sort!{|x,y| x.ord <=> y.ord}

    
    #calculate user hand value
    calculate_value(user_hand)
    hand_value = calculate_value(user_hand)
    
    #calculate dealer hand value
    dealer_value = calculate_value(dealer_hand)

    #print out user_hand and value
    puts "User hand: #{user_hand}       Hand value #{hand_value}"

    if(dealer_value == 21)
        #print out dealer's full cards
        puts "Dealer hand #{dealer_hand}        Dealer value #{dealer_value}"
        puts dealer_value
    else
        #print out dealer's first card + temp value
        #
        temp = []
        temp << dealer_hand[1]
        temp_value = calculate_value(temp)
        puts "Dealer hand " + dealer_hand[1] + "             Dealer hand value: #{temp_value}"
    end



    if hand_value > 21
        puts "BUST!"
        tmp = gameover
        if tmp == 1
            deck = []
            user_hand = []
            dealer_hand = []
            initialize(user_hand, deck, dealer_hand)
            calculate_value(user_hand)
            hand_value = calculate_value(user_hand)
        end
    end

    puts "Hit, Stay, or Abort"
    user_input = gets.chomp!
    user_input.downcase!    

    case user_input
    when "hit"
        #draw from deck, recalculate values
        user_hand << deck.delete_at(rand(deck.length))
    when "stay"

        #puts dealer_value
        while(true)
            if(dealer_value >= hand_value)
                puts "Dealer wins with a value of #{dealer_value} > #{hand_value}"
                tmp = gameover
                if tmp == 1
                        deck = []
                        user_hand = []
                        dealer_hand = []
                        initialize(user_hand, deck, dealer_hand)
                        calculate_value(user_hand)
                        hand_value = calculate_value(user_hand)
                        tmp == 0
                    end
                break
            else
                while(dealer_value < 15 || dealer_value < hand_value)
                    dealer_hand << deck.delete_at(rand(deck.length))
                    dealer_value = calculate_value(dealer_hand)
                    #puts "Dealer value is now #{dealer_value}"
                end
                if dealer_value > 21 || hand_value > dealer_value
                    puts "You win!"
                    tmp = gameover
                    if tmp == 1
                        deck = []
                        user_hand = []
                        dealer_hand = []
                        initialize(user_hand, deck, dealer_hand)
                        calculate_value(user_hand)
                        hand_value = calculate_value(user_hand)
                        puts "Your hand is #{user_hand}"
                        puts "Your hand is #{hand_value}"
                        tmp == 0
                    end
                    break
                end
            end
        end
    when "abort"
        #end program
        abort("Thank you for playing!")
    else
        puts "Incorrect input"
    end
end
