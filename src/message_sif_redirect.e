note
	description: "Summary description for {MESSAGE_SIF_REDIRECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_SIF_REDIRECT

inherit
	MESSAGE_SIF
		rename
			make as message_sif_make
		redefine
			data_unit_to_transmit
		end

create
	make

feature -- Creation

	make(a_application_layer: LAYER_APPLICATION; a_uri: STRING)
			-- Creation
		do
			uri := a_uri
			message_sif_make("message_sif_redirect", a_application_layer, false)
		end

feature -- Transmission

	data_unit_to_transmit: STRING
			-- <Precursor>
		local
			l_conv_to: JSON_REFLECTOR_SERIALIZER
			l_ctx: detachable JSON_SERIALIZER_CONTEXT
			l_message_redirect_expanded: MESSAGE_SIF_REDIRECT_EXPANDED
		do
			create l_message_redirect_expanded.make(Current)

			create l_conv_to
			create l_ctx
			l_ctx.set_is_type_name_included(false)
			l_ctx.set_default_serializer (create {JSON_REFLECTOR_SERIALIZER})

			Result := l_conv_to.to_json_string(l_message_redirect_expanded, l_ctx)
		end

feature -- Implementation

	uri: STRING

end
