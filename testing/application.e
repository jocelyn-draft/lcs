note
	description: "[
			Enter class description here!
		]"

class
	APPLICATION

inherit
	ANY
		rename
			print as ascii_print
		end

	LOCALIZED_PRINTER
		rename
			print as ascii_print,
			localized_print as print
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Instantiate Current object.
		do
			display_lcs ({STRING_32}"Test ABC ?", {STRING_32}"ni=A,hao=B,ma=C")
			print ("%N")

			display_lcs ({STRING_32}"Test 你好吗 ?", {STRING_32}"ni=你,hao=好,ma=吗")
			print ("%N")

			display_lcs ("ACFGHD", "ABFHD")
			print ("%N")

			display_lcs ("HELLO EIFFEL WORLD", "HLO E1FFEL W0RLDD!")
			print ("%N")

			display_lcs ("HELLO EIFFEL WORLD", "E1FFEL")
			print ("%N")
		end

	display_lcs (x,y: READABLE_STRING_GENERAL)
		local
			lcs: expanded LCS_UTILITIES
			s: STRING_32
		do
			create s.make_empty
			s.append ("LCS(%"")
			s.append_string_general (x)
			s.append ("%", %"")
			s.append_string_general (y)
			s.append ("%") = %"")
			s.append_string_general (lcs.lcs (x, y))
			s.append ("%"")
			print (s)
			print ("%N")
		end

note
	copyright: "2015-2015, Jocelyn Fiat, and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			https://eiffel.org/
			Author: eiffel@djoce.net
		]"
end
