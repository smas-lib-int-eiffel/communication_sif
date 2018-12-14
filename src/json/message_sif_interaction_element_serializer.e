note
	description: "Summary description for {MESSAGE_SIF_INTERACTION_ELEMENT_SERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_SIF_INTERACTION_ELEMENT_SERIALIZER
inherit
	JSON_SERIALIZER

feature -- Conversion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			j_object: JSON_OBJECT
			j_value: detachable JSON_VALUE
			i: INTEGER
			l_json_string: detachable JSON_STRING
		do
			if attached {MESSAGE_SIF_INTERACTION_ELEMENT_EXPANDED} obj as msg then
				create j_object.make_with_capacity (3)

					-- "id_message"
				j_object.put_string (msg.id_message, "id_message")
					-- "type"
				j_object.put_string (msg.ie_control_expanded.type_name_interaction_element.as_lower, "type")
					-- "identifier"
				j_object.put_integer (msg.identifier, "identifier")
					-- "view_identifier"
				j_object.put_integer (msg.view_identifier, "view_identifier")
					-- Specific control events occured
				j_value := ctx.to_json (msg.ie_control_expanded, Current)
				if attached {JSON_OBJECT}j_value as la_json_object then
					from
						i := 1
					until
						i > la_json_object.count
					loop
						l_json_string := la_json_object.current_keys[i]
						if attached la_json_object.item(l_json_string) as la_json_value then
							j_object.put(la_json_value, l_json_string)
						end
						i := i + 1
					end
				end
				Result := j_object
			else
				create {JSON_NULL} Result
			end
		end

end
