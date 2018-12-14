note
	description: "Summary description for {MESSAGE_SIF_VIEW_WEB}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_SIF_VIEW_WEB

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

	make(a_application_layer: LAYER_APPLICATION; a_view_web: SIF_VIEW_WEB; a_action: like action)
			-- Creation
		do
			view := a_view_web
			action := a_action
			message_sif_make("message_sif_web_view", a_application_layer, false)
		end

feature -- Transmission

	data_unit_to_transmit: STRING
			-- <Precursor>
		local
			l_conv_to: JSON_REFLECTOR_SERIALIZER
			l_ctx: detachable JSON_SERIALIZER_CONTEXT
			l_view_object_information: MESSAGE_SIF_VIEW_EXPANDED
		do
			create l_view_object_information.make(Current)

			create l_conv_to
			create l_ctx
			l_ctx.set_is_type_name_included(false)
			l_ctx.register_serializer (create {MESSAGE_SIF_VIEW_WEB_SERIALIZER}, {MESSAGE_SIF_VIEW_EXPANDED})
			l_ctx.register_serializer (create {INTERACTION_ELEMENT_SERIALIZER}, {INTERACTION_ELEMENT_EXPANDED})

			Result := l_conv_to.to_json_string(l_view_object_information, l_ctx)
		end

feature -- Implementation

	view: SIF_VIEW_WEB

	action: like {ENUMERATION_VIEW_ACTION}.action

end
