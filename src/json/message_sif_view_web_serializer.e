note
	description: "Summary description for {MESSAGE_SIF_VIEW_WEB_SERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_SIF_VIEW_WEB_SERIALIZER
inherit
	JSON_SERIALIZER

feature -- Conversion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			j_object: JSON_OBJECT
			j_array: JSON_ARRAY
			j_value: detachable JSON_VALUE
			i: INTEGER
		do
			if attached {MESSAGE_SIF_VIEW_EXPANDED} obj as msg then
				create j_object.make_with_capacity (4)

				ctx.on_object_serialization_start (msg)
					-- "id_message"
				j_object.put_string (msg.id_message, "id_message")
					-- "action"
				j_object.put_integer (msg.action, "action")
					-- "view_identifier"
				j_object.put_integer (msg.view_identifier, "view_identifier")
					-- "HTML"
				j_object.put_string (msg.view_html, "html")

				create j_array.make_empty
				if attached msg.view_interaction_elements_set as l_ies then
					from
						l_ies.start
						i := 1
					until
						l_ies.off
					loop
						j_value := ctx.to_json (l_ies.item, Current)
						if j_value = Void then
							check type_serializable: False end
							j_value := create {JSON_NULL}
						end
						j_array.extend (j_value)
						i := i + 1
						l_ies.forth
					end
				end
				j_object.put (j_array, "interaction_elements")

				Result := j_object
				ctx.on_object_serialization_end (j_object, msg)
			else
				create {JSON_NULL} Result
			end
		end

end
