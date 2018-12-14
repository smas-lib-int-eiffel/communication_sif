note
	description: "Summary description for {INTERACTION_ELEMENT_SERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTERACTION_ELEMENT_SERIALIZER
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
			if attached {INTERACTION_ELEMENT_EXPANDED} obj as ie then
				create j_object.make_with_capacity (2)

					-- "identifier"
				j_object.put_integer (ie.identifier, "identifier")
					-- "type"
				j_object.put_string (ie.type_name, "type")

				Result := j_object
			else
				create {JSON_NULL} Result
			end
		end

end
