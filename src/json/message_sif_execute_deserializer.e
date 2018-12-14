note
	description: "Summary description for {MESSAGE_SIF_EXECUTE_DESERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_SIF_EXECUTE_DESERIALIZER

inherit
	JSON_DESERIALIZER

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable MESSAGE_SIF_EXECUTE_EXPANDED
		local
			conv_from: SIF_JSON_DESERIALIZER_IE_CONTROL_WEB_EVENT
			i: INTEGER
		do
			if attached {JSON_OBJECT} a_json as j_msg_sif_execute_expanded then
				create Result.make ("message_sif_web_execute")
				if attached {JSON_OBJECT} j_msg_sif_execute_expanded.item ("arguments") as j_arguments then
					from
						i := 1
					until
						i > j_arguments.current_keys.count
					loop
						if attached {JSON_STRING}j_arguments.item (j_arguments.current_keys.at(i)) as l_argument and then
						   l_argument.is_string and then
						   j_arguments.current_keys.at(i).is_string then
							Result.arguments.extend(l_argument.item, j_arguments.current_keys.at(i).item)
						end
						i := i + 1
					end
				end
			end
		end

end
