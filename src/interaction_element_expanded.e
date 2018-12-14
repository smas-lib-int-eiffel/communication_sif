note
	description: "Summary description for {INTERACTION_ELEMENT_EXPANDED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTERACTION_ELEMENT_EXPANDED

create
	make

feature
	make (a_identifier: like {SIF_INTERACTION_ELEMENT}.identifier; a_type_name: READABLE_STRING_8)
		do
			identifier := a_identifier
			type_name := a_type_name.as_lower
		end

	identifier: like {SIF_INTERACTION_ELEMENT}.identifier

	type_name: READABLE_STRING_8

end
