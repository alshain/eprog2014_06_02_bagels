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
			n, i: INTEGER
			s: STRING
			random: V_RANDOM
			winn: BOOLEAN
		do
			Io.put_string ("Enter number of digits: ")
			Io.read_integer
			n:= Io.last_integer
			i:= 1
			s:= ""
			from
				create random
			until
				i > n
			loop
				s:= s + random.bounded_item (1, 9).out
				random.forth
				i:= i + 1
			end
			Io.put_string (s)
			set_answer(s)
			from
				i:= 1
			until
				winn
			loop
				Io.put_string ("%NGuess "+ i.out + ":")
				Io.read_word
				from

				until
					Io.last_string.count = answer.count
				loop
					Io.put_string ("%NYour guess isn't a "+ answer.count.out +"-digit number, guess again: ")
					Io.read_word
				end

				Io.put_string (clue(Io.last_string))
				if clue(Io.last_string).count = answer.count * 6 + 1 then
					winn:= true
				end
				i:= i + 1

			end
				Io.put_string ("Answer: " + answer)
		end

feature -- Implementation

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

	clue (guess: STRING): STRING
			-- Clue for `guess' with respect to `answer'.
		require
			answer_exists: answer /= Void
			guess_exists: guess /= Void
			same_length: answer.count = guess.count
		local
			m: like answer.new_cursor
			fermi, pico, copie: STRING
			is_pico: BOOLEAN
			i: INTEGER
		do
			fermi:= "%T"
			pico:= ""
			copie:= ""
			copie.copy (guess)
			from
				i:= 1
			until
				i > answer.count
			loop
				if guess[i] = answer[i] then
					fermi:= fermi + "Fermi "
					copie.remove (copie.index_of (guess[i], 1))
				else
					is_pico:= False
					from
						m:= guess.new_cursor
					until
						is_pico or else m.after
					loop
						if not copie.has (m.item)  then
							m.forth
						else
							if answer[i] = m.item then
								pico:= pico + "Pico "
								copie.remove (copie.index_of (m.item, 1))
								is_pico:= True
							else
								m.forth
							end
						end
					end
				end
				i:= i + 1
			end
			if fermi.count + pico.count = 1 then
				Result:= "Bagels"
			else
				Result:= fermi + pico
			end
		end
end
