note
	description: "Summary description for {OR_OPERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OR_OPERATOR

inherit
	BINARY_OPERATOR_INTERFACE

feature
	token_value: STRING
		attribute Result := "||" end
end