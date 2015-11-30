note
	description: "Collection of string utilities."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_UTILITIES

inherit
	LCS_UTILITIES

	LEVENSHTEIN_DISTANCE_UTILITIES
		undefine
			default_create
		end

note
	copyright: "2015-2015, Jocelyn Fiat, Larry Rix, Eiffel Software, and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			https://eiffel.org/
			Author: eiffel@djoce.net
		]"
end
