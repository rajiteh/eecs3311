note
	description: "Summary description for {EXISTS_OPERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXISTS_OPERATOR

inherit
	UNARY_OPERATOR_INTERFACE
--	

feature
	token_value: STRING
		attribute Result := "||" end
end
