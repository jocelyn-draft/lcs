note
	description: "[
			Longest Common Subsequence.
		]"

class
	LCS

inherit
	DEBUG_OUTPUT
		rename
			debug_output as value
		end

create
	make
	
convert
	value: {READABLE_STRING_32,STRING_32}

feature {NONE} -- Initialization

	make (s1, s2: READABLE_STRING_GENERAL)
			-- Instantiate Current object.
		do
			x := s1
			y := s2
			c_code := ('c').natural_32_code
			u_code := ('u').natural_32_code
			l_code := ('l').natural_32_code
			compute
		end

feature -- Access

	value: STRING_32
			-- Longest Common Subsequence value.
	
feature {NONE} -- Implementation

	x,y: READABLE_STRING_GENERAL

	c_code: NATURAL_32
	u_code: NATURAL_32
	l_code: NATURAL_32

	compute
		local
			m,n: INTEGER
			i,j: INTEGER
			c: ARRAY2 [INTEGER]
			b: ARRAY2 [NATURAL_32]
		do
			create value.make_empty
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
			output (m, n, value, c, b)
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

	output (i,j: INTEGER; a_target: STRING_32; c: ARRAY2 [INTEGER]; b: ARRAY2 [NATURAL_32])
		do
			if i = 0 or j = 0 then

			elseif b[i+1, j+1] = c_code then
				output (i-1, j-1, a_target, c, b)
				a_target.append_character (x [i])
			elseif b[i+1, j+1] = u_code then
				output (i-1, j, a_target, c, b)
			else
				output (i, j-1, a_target, c, b)
			end
		end

note
	copyright: "2015-2015, Jocelyn Fiat, and Eiffel Software."
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Author: eiffel@djoce.net
		]"
end
