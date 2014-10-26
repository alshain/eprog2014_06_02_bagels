note
	description : "Bagels application"

class
	BAGELS

create
	execute, set_answer

feature -- Initialization
	execute
			-- Play bagels.
		local
			d: INTEGER
		do
			Io.put_string ("*** Welcome to Bagels! ***%N")
			from
			until
				Io.last_integer > 0
			loop
				Io.put_string ("Enter the number of digits (positive):%N")
				Io.read_integer
			end
			d := Io.last_integer
			play (d)
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
			Io.put_string ("I'm thinking of a number...")
			generate_answer (d)
			Io.put_string (" Okay, got it!%N")

			from
			until
				guess ~ answer
			loop
				Io.put_string ("Enter your guess: ")
				Io.read_line
				guess := Io.last_string
				if guess.count = d and guess.is_natural and not guess.has ('0') then
					print (clue (guess) + "%N")
					guess_count := guess_count + 1
				else
					Io.put_string ("Incorrect input: please enter a positive number with " + d.out + " digits containing no zeros%N")
				end
			end
			print ("Congratulations! You made it in " + guess_count.out + " guesses.")
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
			-- Generate a number with `d' nonzero digits and store it in `answer'.
		require
			d_positive: d > 0
		local
			random: V_RANDOM
			i: INTEGER
		do
			create answer.make_filled (' ', d)
			create random
			from
				i := 1
			until
				i > d
			loop
				answer [i] := (random.bounded_item (1, 9)).out [1]
				random.forth
				i := i + 1
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
			i, k: INTEGER
			answer_copy, guess_copy: STRING
		do
			Result := ""
			answer_copy := answer.twin
			guess_copy := guess.twin
			from
				i := 1
			until
				i > answer_copy.count
			loop
				if answer_copy [i] = guess_copy [i] then
					Result := Result + "Fermi "
					answer_copy [i] := ' '
					guess_copy [i] := ' '
				end
				i := i + 1
			end
			from
				i := 1
			until
				i > answer_copy.count
			loop
				if answer_copy [i] /= ' ' then
					k := guess_copy.index_of (answer_copy [i], 1)
					if k > 0 then
						Result := Result + "Pico "
						guess_copy [k] := ' '
					end
				end
				i := i + 1
			end
			if Result.is_empty then
				Result := "Bagels"
			end
		ensure
			result_exists: Result /= Void
		end
end
