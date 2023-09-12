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
		when "Rock"
		    if @player_choice == "Paper"
		        @outcome = "You Win"
		    else
		        @outcome = "You Lose"
		    end
		when "Paper"
		    if @player_choice == "Scissors"
		        @outcome = "You Win"
		    else
		        @outcome = "You Lose"
		    end
		when "Scissors"
		    if @player_choice == "Rock"
		        @outcome = "You Win"
		    else
		        @outcome = "You Lose"
		    end
		end
	end
	puts @outcome
	erb :results
end