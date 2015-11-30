note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	LEVENSHTEIN_DISTANCE_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_1
			-- New test routine
		do
			test_distance ("kitten", "sitting", 3)
			test_distance ("kitten", "sitten", 1)
			test_distance ("sitten", "sittin", 1)
			test_distance ("sittin", "sitting", 1)
		end

	test_2
		do
			test_distance ("Eiffel", "E1ffel", 1)
			test_distance ("ACFGHD", "ABFHD", 2)
			test_distance ("HELLO EIFFEL WORLD", "HLO E1FFEL W0RLDD!", 6)
			test_distance ("HELLO EIFFEL WORLD", "E1FFEL", 13)
			test_distance ({STRING_32}"Test ABC ?", {STRING_32}"a=A,b=B,c=C", 10)
			test_distance ({STRING_32}"Test 你好吗 ?", {STRING_32}"ni=你,hao=好,ma=吗", 14)
		end

	test_distance (a,b: READABLE_STRING_GENERAL; a_result: INTEGER)
		local
			ut: expanded LEVENSHTEIN_DISTANCE_UTILITIES
			l_tag: STRING_32
		do
			create l_tag.make_empty
			l_tag.append ("Distance(%"")
			l_tag.append_string_general (a)
			l_tag.append ("%",%"")
			l_tag.append_string_general (b)
			l_tag.append ("%")=")
			l_tag.append_integer (a_result)
			assert_32 (l_tag, a_result = ut.distance (a, b))
		end

note
	copyright: "2015-2015, Jocelyn Fiat, and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			https://eiffel.org/
			Author: eiffel@djoce.net
		]"
end


