note
	description: "Summary description for {MESSAGE_SIF_INTERACTION_ELEMENT_DESERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_SIF_INTERACTION_ELEMENT_DESERIALIZER

inherit
	JSON_DESERIALIZER

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable MESSAGE_SIF_INTERACTION_ELEMENT_EXPANDED
		local
			conv_from_event: SIF_JSON_DESERIALIZER_IE_CONTROL_WEB_EVENT
			conv_from_text:	 SIF_JSON_DESERIALIZER_IE_CONTROL_WEB_TEXT
			conv_from_list: SIF_JSON_DESERIALIZER_IE_CONTROL_WEB_LIST
		do
			if attached {JSON_OBJECT} a_json as j_msg_sif_ie_expanded then
				if attached {JSON_NUMBER} j_msg_sif_ie_expanded.item ("view_identifier") as l_view_identifier and then
				   l_view_identifier.is_integer and then
				   attached {JSON_NUMBER} j_msg_sif_ie_expanded.item ("identifier") as l_interaction_element_identifier and then
				   l_interaction_element_identifier.is_integer and then
				   attached {JSON_STRING} j_msg_sif_ie_expanded.item ("type") as l_interaction_element_type then
				   	if l_interaction_element_type.is_equal("sif_ie_event") then
						create conv_from_event
						ctx.register_deserializer (create {SIF_JSON_DESERIALIZER_IE_CONTROL_WEB_EVENT}, {SIF_IE_CONTROL_EVENT_EXPANDED})
						if attached {SIF_IE_CONTROL_EVENT_EXPANDED}conv_from_event.from_json_string (j_msg_sif_ie_expanded.representation, ctx, {SIF_IE_CONTROL_EVENT_EXPANDED}) as l_ie_control_event_expanded then
							create Result.make ("message_sif_web_interaction", l_interaction_element_identifier.integer_64_item, l_view_identifier.integer_64_item, l_ie_control_event_expanded)
						end
				   	end
				   	if l_interaction_element_type.is_equal("sif_ie_text") then
						create conv_from_text
						ctx.register_deserializer (create {SIF_JSON_DESERIALIZER_IE_CONTROL_WEB_TEXT}, {SIF_IE_CONTROL_TEXT_EXPANDED})
						if attached {SIF_IE_CONTROL_TEXT_EXPANDED}conv_from_text.from_json_string (j_msg_sif_ie_expanded.representation, ctx, {SIF_IE_CONTROL_TEXT_EXPANDED}) as l_ie_control_text_expanded then
							create Result.make ("message_sif_web_interaction", l_interaction_element_identifier.integer_64_item, l_view_identifier.integer_64_item, l_ie_control_text_expanded)
						end
				   	end
				   	if l_interaction_element_type.is_equal("sif_ie_list") then
						create conv_from_list
						ctx.register_deserializer (create {SIF_JSON_DESERIALIZER_IE_CONTROL_WEB_LIST}, {SIF_IE_CONTROL_LIST_EXPANDED})
						if attached {SIF_IE_CONTROL_LIST_EXPANDED}conv_from_list.from_json_string (j_msg_sif_ie_expanded.representation, ctx, {SIF_IE_CONTROL_LIST_EXPANDED}) as l_ie_control_list_expanded then
							create Result.make ("message_sif_web_interaction", l_interaction_element_identifier.integer_64_item, l_view_identifier.integer_64_item, l_ie_control_list_expanded)
						end
				   	end
				end
			end
		end

end
