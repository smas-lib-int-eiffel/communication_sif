note
	description: "Summary description for {LAYER_APPLICATION_SIF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LAYER_APPLICATION_SIF

inherit
	LAYER_APPLICATION
		rename
			make as layer_application_make
		redefine
			initialize
		end

create
	make

feature -- Creation

	make(a_product_web_application: SIF_PRODUCT_WEB_APPLICATION)
			-- The feature to be able to create an instance
		local
			l_in_message: MESSAGE
		do
			layer_application_make
			product_web_application := a_product_web_application
			create {MESSAGE_SIF_INTERACTION_ELEMENT}l_in_message.make (Current)
			create {MESSAGE_SIF_EXECUTE}l_in_message.make (Current)
		end

feature -- Element change

	put_system_interface(a_system_interface_user_viewable_web: SIF_SI_USER_VIEWABLE_WEB_APPLICATION)
		do
			system_interface := a_system_interface_user_viewable_web
			a_system_interface_user_viewable_web.put_layer_application(Current)
		end

feature -- Initial execution

	initialize
			-- This feature is called when a lower session layer is sure of being in a connected state.
			-- So proper actions can be taken if needed to make use of a connected communication stack.
		do
			if attached system_interface as l_system_interface then
				product_web_application.manufacture_dynamic_views (l_system_interface)
			end
		end

feature {SIF_SI_USER_VIEWABLE_WEB_APPLICATION} -- Views

	handle_view(a_web_view: SIF_VIEW_WEB; a_action: like {MESSAGE_SIF_VIEW_WEB}.action )
			-- Communicate the html string of the web view to be presented
		local
			l_msg_view: MESSAGE_SIF_VIEW_WEB
		do
			create l_msg_view.make (Current, a_web_view, a_action)
			transmit (l_msg_view.data_unit_to_transmit)
		end

feature {SIF_IE_CONTROL_WEB} -- Web interaction

	web_interact(a_web_control: SIF_IE_CONTROL_WEB)
		local
			l_msg_interaction_element: MESSAGE_SIF_INTERACTION_ELEMENT
		do
			create l_msg_interaction_element.make_with_control(Current, a_web_control)
			transmit (l_msg_interaction_element.data_unit_to_transmit)
		end

feature {SIF_VIEW_WEB} -- Web redirection

	web_redirect(a_uri: STRING)
		local
			l_msg_interaction_element: MESSAGE_SIF_REDIRECT
		do
			create l_msg_interaction_element.make(Current, a_uri)
			transmit (l_msg_interaction_element.data_unit_to_transmit)
		end

feature {MESSAGE_SIF} -- System Interface

	system_interface: detachable SIF_SI_USER_VIEWABLE_WEB_APPLICATION
			-- The system interface for this sif application layer

	product_web_application: SIF_PRODUCT_WEB_APPLICATION
			-- The user viewable product for this sif application layer

end
