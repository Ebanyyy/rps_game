require 'sinatra'

get '/' do 
	erb :index
end

post '/play' do 
	@player_name = params[:name]
	erb :play 
end

post '/results' do 
	@player_name = params[:name]
	@player_choice = params[:choice]
	@computer_choice = ["Rock", "Paper", "Sciccors"].sample

	if @player_choice == @computer_choice
		@outcome = "Draw!"
	else
	 	case @computer_choice 
		when @player_choice == "Rock"
		    if @computer_choice == "Paper"
		        @outcome = "You Lose"
		    end
		    if @computer_choice == "Scissors"
		        @outcome = "You Win"
		    end
		when @player_choice == "Paper"
		    if @computer_choice == "Scissors"
		        @outcome = "You Lose"
		    end
		    if @computer_choice == "Rock"
		        @outcome = "You Win"
		    end
		when @player_choice == "Scissors"
		    if @computer_choice == "Rock"
		        @outcome = "You Lose"
		    end
		    if @computer_choice == "Paper"
		        @outcome = "You Win"
		    end
		end
	end
	erb :results
end