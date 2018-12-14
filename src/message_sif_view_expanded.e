note
	description: "Summary description for {MESSAGE_SIF_VIEW_EXPANDED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_SIF_VIEW_EXPANDED

create
	make

feature -- Creation

	make(a_msg_sif_view_web: MESSAGE_SIF_VIEW_WEB)
		do
			id_message := a_msg_sif_view_web.id_message
			action := a_msg_sif_view_web.action
			view_identifier := a_msg_sif_view_web.view.identifier
			create view_interaction_elements_set.make(0)
			if attached a_msg_sif_view_web.view.interaction_elements_set as l_ies then
				from
					l_ies.start
				until
					l_ies.off
				loop
					view_interaction_elements_set.force(create {INTERACTION_ELEMENT_EXPANDED}.make (l_ies.item.identifier, l_ies.item.generator))
					l_ies.forth
				end
			end
			if action = {ENUMERATION_VIEW_ACTION}.present then
				view_html := a_msg_sif_view_web.view.html
			else
				view_html := ""
			end
		end

feature -- Implementation

	id_message: like {MESSAGE_SIF}.id_message

	action: like {ENUMERATION_VIEW_ACTION}.action

	view_identifier: like {SIF_VIEW_WEB}.identifier

	view_interaction_elements_set: ARRAYED_LIST[INTERACTION_ELEMENT_EXPANDED]

	view_html : like {SIF_VIEW_WEB}.html

end
