note
	description: "Summary description for {MESSAGE_SIF_EXECUTE_EXPANDED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_SIF_EXECUTE_EXPANDED

create
	make

feature -- Creation

	make(a_id_message: like id_message)
		do
			id_message := a_id_message
			create arguments.make(0)
		end

feature -- Implementation

	id_message: like {MESSAGE_SIF}.id_message

	arguments: STRING_TABLE[STRING]
			-- The hashed string table where the string values are considered as being arguments to the web product application

end
