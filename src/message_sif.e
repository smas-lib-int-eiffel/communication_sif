note
	description: "Summary description for {MESSAGE_SIF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MESSAGE_SIF

inherit
	MESSAGE
		rename
			make as make_message
		redefine
			do_parse
		end


feature -- Initialization

	make(a_id_message: like id_message; a_application_layer: LAYER_APPLICATION; a_is_in_message: BOOLEAN)
			-- Initialize the message with an identifier
		do
			id_message := a_id_message
			make_message(a_application_layer, a_is_in_message)
		end

feature -- Identification

	id_message: READABLE_STRING_8
			-- The unique identifier of the message, with which messages can be identified quickly

feature {NONE} -- Implementation

	do_parse(a_data_unit: READABLE_STRING_8)
			-- <Precursor>
		local
			l_parser: JSON_PARSER
		do
			if not a_data_unit.is_empty then
				create l_parser.make_with_string (a_data_unit)
				l_parser.parse_content

				if l_parser.is_valid then
					if attached {JSON_OBJECT}l_parser.parsed_json_value as jo and then
					   attached {JSON_STRING} jo.item ("id_message") as l_id_message then
						if l_id_message.is_equal(id_message) then
							do_parse_json(a_data_unit, jo)
						end
					end
				end
			end
		end

	do_parse_json(a_json_string: READABLE_STRING_8; a_json_object: JSON_OBJECT)
			-- Parse the json object, which seems to be a sif message
			-- Identify all mandatory fields for the current received message
		do
		end

end
