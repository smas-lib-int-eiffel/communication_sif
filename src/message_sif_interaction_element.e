note
	description: "Summary description for {MESSAGE_SIF_INTERACTION_ELEMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_SIF_INTERACTION_ELEMENT

inherit
	MESSAGE_SIF
		rename
			make as message_sif_make
		redefine
			reset,
			data_unit_to_transmit,
			execute,
			do_parse_json
		end

create
	make, make_with_control

feature -- Creation

	make(a_application_layer: LAYER_APPLICATION)
			-- Creation of a message of type interaction which can be received from a user agent or other client
		do
			web_control := void
			message_sif_make("message_sif_web_interaction", a_application_layer, true)
		end

	make_with_control(a_application_layer: LAYER_APPLICATION; a_web_control: SIF_IE_CONTROL_WEB)
			-- Creation of a message which can be transmitted to a user agent or other client
		do
			web_control := a_web_control
			message_sif_make("message_sif_web_interaction", a_application_layer, false)
		end

feature -- Configuration

	reset
			-- Any properties set for flow and state need to reset to be able to reuse the same message
		do
			web_control := void
			message_sif_interaction_element_expanded := void
		end

feature -- Transmission

	data_unit_to_transmit: STRING
			-- <Precursor>
		local
			conv_to: JSON_REFLECTOR_SERIALIZER
			ctx: detachable JSON_SERIALIZER_CONTEXT
			l_message_ie_expanded: MESSAGE_SIF_INTERACTION_ELEMENT_EXPANDED
		do
			create Result.make_empty
			if attached web_control as l_web_control then
				create l_message_ie_expanded.make_from_message_and_control(Current, l_web_control)

				create conv_to
				create ctx
				ctx.set_is_type_name_included(false)
				ctx.register_serializer (create {MESSAGE_SIF_INTERACTION_ELEMENT_SERIALIZER}, {MESSAGE_SIF_INTERACTION_ELEMENT_EXPANDED})
				ctx.register_serializer (l_web_control.expanded_type_serializer, l_web_control.type_expanded)

				Result := conv_to.to_json_string(l_message_ie_expanded, ctx)
			end
		end

feature -- Execution

	execute(a_data_unit: READABLE_STRING_8)
			-- <Precursor>
		do
			if attached web_control as l_web_control and then
			   attached message_sif_interaction_element_expanded as l_message_sif_interaction_element_expanded then
				l_web_control.handle_interaction (l_message_sif_interaction_element_expanded.ie_control_expanded)
			end
		end

	do_parse_json(a_json_string: READABLE_STRING_8; a_json_object: JSON_OBJECT)
			-- Parse the json, which seems to be a sif message
		local
			l_type: STRING
			conv_from: MESSAGE_SIF_INTERACTION_ELEMENT_DESERIALIZER
			ctx_deser: detachable JSON_DESERIALIZER_CONTEXT
		do
			if attached {JSON_NUMBER} a_json_object.item ("view_identifier") as l_view_identifier and then
			   l_view_identifier.is_integer and then
			   attached {JSON_NUMBER} a_json_object.item ("identifier") as l_interaction_element_identifier and then
			   l_interaction_element_identifier.is_integer and then
			   attached {LAYER_APPLICATION_SIF}application_layer as l_layer_application_sif and then
			   attached l_layer_application_sif.system_interface as l_system_interface_user_viewable and then
			   attached {SIF_VIEW_WEB}l_system_interface_user_viewable.view_activated (l_view_identifier.integer_64_item) as l_activated_web_view and then
			   attached l_activated_web_view.interaction_elements_set.interaction_element (l_interaction_element_identifier.integer_64_item) and then
			   attached {SIF_IE_CONTROL_WEB}l_activated_web_view.control(l_interaction_element_identifier.integer_64_item) as l_ie_control then
				create conv_from
				create ctx_deser
				ctx_deser.register_deserializer (create {MESSAGE_SIF_INTERACTION_ELEMENT_DESERIALIZER}, {MESSAGE_SIF_INTERACTION_ELEMENT_EXPANDED})
				if attached {MESSAGE_SIF_INTERACTION_ELEMENT_EXPANDED}conv_from.from_json_string (a_json_string, ctx_deser, {MESSAGE_SIF_INTERACTION_ELEMENT_EXPANDED}) as l_msg_sif_ie_expanded then
					web_control := l_ie_control
					message_sif_interaction_element_expanded := l_msg_sif_ie_expanded
					is_parseable := true
				end
			end
		end

	web_control: detachable SIF_IE_CONTROL_WEB

	message_sif_interaction_element_expanded: detachable MESSAGE_SIF_INTERACTION_ELEMENT_EXPANDED

end
