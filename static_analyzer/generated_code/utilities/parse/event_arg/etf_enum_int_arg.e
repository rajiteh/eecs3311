note
	description: "Summary description for {ETF_INT_ARG}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ENUM_INT_ARG

inherit
	ETF_PRIMITIVE_ARG
		redefine
			out
		end

create
	make

feature -- Constructor
	make(i : INTEGER)
	  do
	  	create src_out.make_empty
	    value := i
	  end

feature -- Queries
	value : INTEGER

feature -- Output
	out : STRING
		do
			Result := value.out
		end
end


