note
	description : "Bagels application"

class
	BAGELS

create
	execute, set_answer

feature -- Initialization
	execute
			-- Play bagels.
		do
			-- Add your code here.
			-- Hint: you could write a loop to read the number of digits 
			-- as user input, and pass it to procedure play.
		end

feature -- Implementation

	play (d: INTEGER)
			-- Generate a number with `d' digits and let the player guess it.
		require
			d_positive: d > 0
		local
			guess_count: INTEGER
			guess: STRING
		do
			-- Add your code here.
			-- Hint: You could generate the correct answer with procedure generate_answer.
			-- Then you could write a loop to read user input (guesses) and count them.
		end


	answer: STRING
			-- Correct answer.		

	set_answer (s: STRING)
			-- Set `answer' to `s'.		
		require
			s_non_empty: s /= Void and then not s.is_empty
			is_natural: s.is_natural
			no_zeros: not s.has ('0')
		do
			answer := s
		ensure
			answer_set:answer = s
		end

	generate_answer (d: INTEGER)
			-- Generate a number with `d' non-zero digits and store it in `answer'.
		require
			d_positive: d > 0
		local
			random: V_RANDOM
			i: INTEGER
		do
			-- Your code here.
		ensure
			answer_exists: answer /= Void
			correct_length: answer.count = d
			is_natural: answer.is_natural
			no_zeros: not answer.has ('0')
		end


	clue (guess: STRING): STRING
			-- Clue for `guess' with respect to `answer'.
		require
			answer_exists: answer /= Void
			guess_exists: guess /= Void
			same_length: answer.count = guess.count
		do
			-- Add your code here.
		end
end
