note
	description: "Summary description for {MESSAGE_SIF_INTERACTION_ELEMENT_EXPANDED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_SIF_INTERACTION_ELEMENT_EXPANDED

create
	make, make_from_message_and_control

feature -- Creation

	make(a_id_message: like id_message; a_identifier: like identifier; a_view_identifier: like view_identifier; a_ie_control_expanded: like ie_control_expanded)
		do
			id_message := a_id_message
			identifier := a_identifier
			view_identifier := a_view_identifier
			ie_control_expanded := a_ie_control_expanded
		end

	make_from_message_and_control(a_msg_sif_interaction_element: MESSAGE_SIF_INTERACTION_ELEMENT; a_web_control: SIF_IE_CONTROL_WEB)
		do
			id_message := a_msg_sif_interaction_element.id_message
			identifier := a_web_control.identifier
			view_identifier := a_web_control.view_identifier
			ie_control_expanded := a_web_control.json_expanded
		end

feature -- Implementation

	id_message: like {MESSAGE_SIF}.id_message

	identifier: like {SIF_INTERACTION_ELEMENT}.identifier

	view_identifier: like {SIF_VIEW_WEB}.identifier

	ie_control_expanded: SIF_IE_CONTROL_EXPANDED

end
