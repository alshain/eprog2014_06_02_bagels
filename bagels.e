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
			Io.put_string ("Hello! Do you want to play a game?%N%N")
			Io.put_string ("Enter the digit of the number you want to guess: ")
			Io.read_integer
			play (Io.input.last_integer)
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
			guess_count:= 0
			-- Add your code here.
			-- Hint: You could generate the correct answer with procedure generate_answer.
			-- Then you could write a loop to read user input (guesses) and count them.
			Io.put_string ("Thinking of random number...%N")
			Io.put_new_line
			generate_answer(d)
			from
			until
				guess ~ answer
			loop
				Io.put_string ("Enter your guessed number: ")
				Io.read_line
				guess:= Io.input.last_string
				if guess.count = d and guess.is_natural and not guess.has ('0') then
					print(clue(guess)+ "%N")
					guess_count:= guess_count + 1
				else
					print("Incorrect input: Please enter a valid digit, that is a natural number and contains no 0 %N")
				end

			end
			print ("You made it! You've guessed the right number after "  +guess_count.out+ " times!")
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
			create answer.make_filled (' ', d)
			create random
			from
				i:= 1
			until
				i > d
			loop
				answer[i] := (random.bounded_item (1, 9)).out[1]
				random.forth
				i:= i+1
			end
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
		local
			i,k: INTEGER
			answer_copy, guess_copy: STRING
		do
			-- Add your code here.
			Result:= ""
			answer_copy:= answer.twin
			guess_copy:= guess.twin
			from
				i:= 1
			until
				i > answer_copy.count
			loop
				if answer_copy[i] = guess_copy[i] then
					Result:= Result + "Fermi "
					answer_copy[i]:= ' '
					guess_copy[i]:= ' '
				end
				i:= i+1
			end

			from
				i:= 1
			until
				i > answer_copy.count
			loop
				if answer_copy[i] /= ' ' then
					k:= guess_copy.index_of (answer_copy[i], 1)
					if k > 0 then
						Result:= Result + "Pico "
						guess_copy[k]:= ' '
					end
				end
			i:= i + 1
			end

			if Result.is_empty then
				Result:= Result + "Bagels %N"

			end

		end
end
