note
	description: "Summary description for {MESSAGE_SIF_EXECUTE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_SIF_EXECUTE

inherit
	MESSAGE_SIF
		rename
			make as message_sif_make
		redefine
			reset,
			execute,
			do_parse_json
		end

create
	make

feature -- Creation

	make(a_application_layer: LAYER_APPLICATION)
			-- Creation of a message of type interaction which can be received from a user agent or other client
		do
			message_sif_make("message_sif_execute", a_application_layer, true)
		end

feature -- Configuration

	reset
			-- Any properties set for flow and state need to reset to be able to reuse the same message
		do
			message_sif_execute_expanded := void
		end

feature -- Execution

	execute(a_data_unit: READABLE_STRING_8)
			-- <Precursor>
		do
			if attached {LAYER_APPLICATION_SIF} application_layer as l_application_layer_sif and then
			   attached l_application_layer_sif.system_interface as l_system_interface and then
			   attached message_sif_execute_expanded as l_message_sif_execute_expanded then
				l_application_layer_sif.product_web_application.execute_initial_controllers (l_system_interface, l_message_sif_execute_expanded.arguments)
			end
		end

	do_parse_json(a_json_string: READABLE_STRING_8; a_json_object: JSON_OBJECT)
			-- Parse the json, which seems to be a sif message
		local
			conv_from: MESSAGE_SIF_EXECUTE_DESERIALIZER
			ctx_deser: detachable JSON_DESERIALIZER_CONTEXT
		do
			create conv_from
			create ctx_deser
			ctx_deser.register_deserializer (create {MESSAGE_SIF_EXECUTE_DESERIALIZER}, {MESSAGE_SIF_EXECUTE_EXPANDED})
			if attached {MESSAGE_SIF_EXECUTE_EXPANDED}conv_from.from_json_string (a_json_string, ctx_deser, {MESSAGE_SIF_EXECUTE_EXPANDED}) as l_msg_sif_execute_expanded then
				message_sif_execute_expanded := l_msg_sif_execute_expanded
				is_parseable := true
			end
		end

	message_sif_execute_expanded: detachable MESSAGE_SIF_EXECUTE_EXPANDED

end
