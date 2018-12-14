note
	description: "Summary description for {MESSAGE_SIF_REDIRECT_EXPANDED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_SIF_REDIRECT_EXPANDED

create
	make

feature -- Creation

	make(a_msg_sif_redirect: MESSAGE_SIF_REDIRECT)
		do
			id_message := a_msg_sif_redirect.id_message
			uri := a_msg_sif_redirect.uri
		end

feature -- Implementation

	id_message: like {MESSAGE_SIF}.id_message

	uri: like {MESSAGE_SIF_REDIRECT}.uri


end
