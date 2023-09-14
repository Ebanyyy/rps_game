require 'sinatra'
enable :sessions

get '/' do 
	if session[:players] == nil
	   session[:players] = []
	else
		session[:players] = session[:players]
	end
	puts session[:players]

	erb :index
end

post '/play' do 
	@player_name = params[:name]
	@rounds = params[:rounds].to_i

	session[:name] = @player_name 
	session[:rounds] = @rounds 
	session[:results] = []

	erb :play 
end

post '/results' do 
	@player_name = params[:name]
	@player_choice = params[:choice]
	@computer_choice = ["Rock", "Paper", "Sciccors"].sample
	@player_score = 0
	@computer_score = 0 

	if @player_choice == @computer_choice
		@outcome = "Draw!"
	else
	 	case @computer_choice 
		when "Rock"
		    if @player_choice == "Paper"
		        @outcome = "You Win"
		        puts @player_score += 1
		    else
		        @outcome = "You Lose"
		        puts @computer_score += 1
		    end
		when "Paper"
		    if @player_choice == "Scissors"
		        @outcome = "You Win"
		        puts @player_score += 1
		    else
		        @outcome = "You Lose"
		        puts @computer_score += 1
		    end
		when "Scissors"
		    if @player_choice == "Rock"
		        @outcome = "You Win"
		        puts @player_score += 1
		    else
		        @outcome = "You Lose"
		        puts @computer_score += 1
		    end
		end
	end
	history = { player: @player_choice, computer: @computer_choice, result: @outcome }
	session[:results] << history
	
	if session[:results].length < session[:rounds]	
		erb :play
	else
		counter_wl = session[:results].map { |hash| hash[:result] } #inside "[]" = take key
		session[:win_count] = counter_wl.count("You Win")
		session[:lose_count] = counter_wl.count("You Lose")
		session[:draw_count] = counter_wl.count("Draw!")

		puts counter_wl

		win_scoreboard = {
			"player_name" => session[:name],
			"win_count" => session[:win_count]
		}
		puts win_scoreboard
		session[:players].append(win_scoreboard)

		erb :results
	end
end

