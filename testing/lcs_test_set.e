note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	LCS_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_1
			-- New test routine
		do
			test_lcs ("ACFGHD", "ABFHD", "AFHD")
			test_lcs ("HELLO EIFFEL WORLD", "HLO E1FFEL W0RLDD!", "HLO EFFEL WRLD")
			test_lcs ("HELLO EIFFEL WORLD", "E1FFEL", "EFFEL")
			test_lcs ({STRING_32}"Test ABC ?", {STRING_32}"a=A,b=B,c=C", {STRING_32}"ABC")
			test_lcs ({STRING_32}"Test 你好吗 ?", {STRING_32}"ni=你,hao=好,ma=吗", {STRING_32}"你好吗")
		end

	test_lcs (a,b: READABLE_STRING_GENERAL; a_result: READABLE_STRING_GENERAL)
		local
			lcs: LCS
			l_tag: STRING_32
		do
			create lcs.make (a, b)
			create l_tag.make_empty
			l_tag.append ("LCS(%"")
			l_tag.append_string_general (a)
			l_tag.append ("%",%"")
			l_tag.append_string_general (b)
			l_tag.append ("%"=%"")
			l_tag.append_string_general (a_result)
			l_tag.append ("%"")
			assert_32 (l_tag, a_result.same_string (lcs.value))
		end

end


