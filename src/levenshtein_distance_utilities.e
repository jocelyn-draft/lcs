note
	description: "[
			Levenshtein distance (also known as edit distance).

			See: https://en.wikipedia.org/wiki/Levenshtein_distance
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	LEVENSHTEIN_DISTANCE_UTILITIES

feature -- Access

	distance (a,b: READABLE_STRING_GENERAL): INTEGER
			-- Levenshtein distance between strings `a' and `b'.
		note
			synopsis: "[
				Example: Calculate distance between "sitting" and "kitten":
				
						k	i	t	t	e	n
					0	1	2	3	4	5	6 <-- set top row to [0 .. m]
				s	1	1	2	3	4	5	6
				i	2	2	1	2	3	4	5
				t	3	3	2	1	2	3	4
				t	4	4	3	2	1	2	3
				i	5	5	4	3	2	2	3
				n	6	6	5	4	3	3	2
				g	7	7	6	5	4	4	3! <-- Answer
					^
					|
					set first column to [0 .. n]
					
				Compute top row and left-most columns first. Then go cell-by-cell
				(e.g. 1 .. n over 1 .. m), row-by-row, column-by-column, computing:
				
				d[i-1, j] + 1		-- a deletion
				d[i, j-1] + 1		-- an insertion
				d[i-1, j-1] + 1		-- a substitution
				
				Taking the minimum of each and putting it in its proper place in
				the d[i, j] array, unless the char's are the same (e.g. a [i - 1] = b [j - 1])
				]"
			language_note: "[
				Eiffel is a 1-based array system and not 0-based, so do not
				read the array element accesses from the 0-based mindset.
				]"
		local
			d: ARRAY2 [INTEGER]
			i, j, m, n: INTEGER
		do
			m := a.count + 1; n := b.count + 1
			create d.make_filled (0, m, n)
			from i := 0 until i = m loop d [i + 1, 1] := i; i := i + 1 end
			from j := 0 until j = n loop d [1, j + 1] := j; j := j + 1 end
			from j := 2 until j > n loop
				from i := 2 until i > m loop
					if a [i - 1] = b [j - 1] then
						d[i, j] := d[i-1, j-1]
					else
						d[i, j] := (d[i-1, j-1] + 1).min (d[i, j-1] + 1).min (d[i-1, j] + 1)
					end
					i := i + 1
				end
				j := j + 1
			end
			Result := d[m, n]
		end

note
	copyright: "2015-2015, Jocelyn Fiat, Larry Rix, Eiffel Software, and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			https://eiffel.org/
			Author: eiffel@djoce.net
		]"
end
