note
	description: "[
			Longest Common Subsequence.
		]"
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"

class
	LCS_UTILITIES

inherit
	ANY
		redefine
			default_create
		end


feature {NONE} -- Initialization

	default_create
			-- Instantiate Current object.
		do
			c_code := ('c').natural_32_code
			u_code := ('u').natural_32_code
			l_code := ('l').natural_32_code
			Precursor
		end

feature -- Access

	lcs (s1, s2: READABLE_STRING_GENERAL): STRING_32
			-- Longest Common Subsequence value.
		do
			create Result.make_empty
			append_lcs (s1, s2, Result)
		end

	append_lcs (x, y: READABLE_STRING_GENERAL; a_output: STRING_GENERAL)
			-- Append LCS of `x,y' to `a_output'.
		require
			a_output.is_string_8 or a_output.is_string_32
		local
			m,n: INTEGER
			i,j: INTEGER
			c: ARRAY2 [INTEGER]
			b: ARRAY2 [NATURAL_32]
			l_value: STRING_32
			utf: UTF_CONVERTER
		do
			m := x.count
			n := y.count
			create c.make_filled (0, m+1, n+1)
			create b.make_filled (0, m+1, n+1)
			from
				i := 1
			until
				i > m
			loop
				from
					j := 1
				until
					j > n
				loop
					if x[i] = y[j] then
						c[i+1, j+1] := c[i, j] + 1
						b[i+1, j+1] := c_code
					elseif c[i, j+1] >= c[i+1, j] then
						c[i+1, j+1] := c[i, j+1]
						b[i+1, j+1] := u_code
					else
						c[i+1, j+1] := c[i+1, j]
						b[i+1, j+1] := l_code
					end

					j := j + 1
				end
				i := i + 1
			end
			debug
				display_array2 (c, False)
				print ("%N")
				display_array2 (b, True)
				print ("%N")
			end

			if attached {STRING_32} a_output as l_output_32 then
				output (x, m, n, l_output_32, c, b)
			else
				create l_value.make_empty
				output (x, m, n, l_value, c, b)
				if attached {STRING_8} a_output as l_output_8 then
					utf.utf_32_string_into_utf_8_string_8 (l_value, l_output_8)
				else
					check string_8_or_32: False end
					a_output.append (l_value)
				end
			end
		end

feature {NONE} -- Implementation

	c_code: NATURAL_32 -- code for 'c'.
	u_code: NATURAL_32 -- code for 'u'.
	l_code: NATURAL_32 -- code for 'l'.

	output (x: READABLE_STRING_GENERAL; i,j: INTEGER; a_target: STRING_32; c: ARRAY2 [INTEGER]; b: ARRAY2 [NATURAL_32])
		do
			if i = 0 or j = 0 then

			elseif b[i+1, j+1] = c_code then
				output (x, i-1, j-1, a_target, c, b)
				a_target.append_character (x [i])
			elseif b[i+1, j+1] = u_code then
				output (x, i-1, j, a_target, c, b)
			else
				output (x, i, j-1, a_target, c, b)
			end
		end

	display_array2 (arr: ARRAY2 [ANY]; is_char: BOOLEAN)
		local
			w,h,i,j: INTEGER
			s,hr,nbline: STRING
			i_w: INTEGER
			l_w: INTEGER
		do
			w := arr.width
			h := arr.height

			i_w := w.out.count
			l_w := h.out.count

			from
				create nbline.make_filled (' ', l_w)
				nbline.append (": ")
				j := 1
			until
				j > w
			loop
				if j > 1 then
					nbline.append (" : ")
				end
				s := j.out
				from until s.count > i_w - 1 loop
					s.prepend_character (' ')
				end
				nbline.append (s)
				j := j + 1
			end
			nbline.append (" :%N")
			create hr.make_filled ('-', nbline.count - 1)
			hr.append_character ('%N')
			from
				i := 1
			until
				i > h
			loop
				s := i.out
				from until s.count > l_w - 1 loop
					s.append_character (' ')
				end
				print (s)
				print ("[ ")
				from
					j := 1
				until
					j > w
				loop
					if is_char and then attached {NATURAL_32} arr[i,j] as ch_code then
						create s.make (1)
						s.append_code (ch_code)
					else
						s := arr[i,j].out
					end
					from until s.count > i_w - 1 loop
						s.prepend_character (' ')
					end
					if j > 1 then
						print (" | ")
					end
					print (s)
					j := j + 1
				end
				print (" ]%N")
				i := i + 1
			end
			print (hr)
			print (nbline)
		end

note
	copyright: "2015-2015, Jocelyn Fiat, Larry Rix, Eiffel Software, and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			https://eiffel.org/
			Author: eiffel@djoce.net
		]"
end
