note
	description: "Summary description for {ENUMERATION_VIEW_ACTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENUMERATION_VIEW_ACTION


inherit
	ANY
		redefine
			default_create
		end

feature -- Creation

	default_create
		do
			action := activate
		end

feature -- Types

	activate: like action = 1
			-- Activate a view

	present: like action = 2
			-- Present the view, make it visible

	hide: like action = 3
			-- Hide the view, make the view invisible

	deactivate: like action = 4
			-- Deactivate the view

	reactivate: like action = 5
			-- Reactivate the view

	destroy: like action = 6
			-- Destroy the view


feature -- Contract support

	is_type_valid (a_type: like action): BOOLEAN
			-- If `a_type' valid?
		do
			inspect a_type
			when activate, present, hide, deactivate, reactivate, destroy then
				Result := True
			else
			end
		end

feature -- Query

	action_type_as_string( a_type: like action ): STRING
			-- Result is a string representation of a_type.
		do
			create Result.make_empty
			inspect a_type
			when activate then
				create Result.make_from_string("activate")
			when present then
				create Result.make_from_string("present")
			when hide then
				create Result.make_from_string("hide")
			when deactivate then
				create Result.make_from_string("deactivate")
			when reactivate then
				create Result.make_from_string("reactivate")
			when destroy then
				create Result.make_from_string("destroy")
			end
		end

	is_action_type_mappable( a_action_type: STRING ): BOOLEAN
			-- Is action type mappable to a known view action?
		do
			a_action_type.to_lower
			if a_action_type.is_equal ("activate") then
				Result := True
			end
			if a_action_type.is_equal ("present") then
				Result := True
			end
			if a_action_type.is_equal ("hide") then
				Result := True
			end
			if a_action_type.is_equal ("deactivate") then
				Result := True
			end
			if a_action_type.is_equal ("reactivate") then
				Result := True
			end
			if a_action_type.is_equal ("destroy") then
				Result := True
			end
		end

	map_action_type( a_action_type: STRING ): like action
			-- Map the action type string, to a action type
		require
			content_is_mappable: is_action_type_mappable( a_action_type )
		do
			a_action_type.to_lower
			if a_action_type.is_equal ("activate") then
				Result := activate
			end
			if a_action_type.is_equal ("present") then
				Result := present
			end
			if a_action_type.is_equal ("hide") then
				Result := hide
			end
			if a_action_type.is_equal ("deactivate") then
				Result := deactivate
			end
			if a_action_type.is_equal ("reactivate") then
				Result := reactivate
			end
			if a_action_type.is_equal ("destroy") then
				Result := destroy
			end
		end

feature -- Access

	is_activate: BOOLEAN
			-- Is `state' `activate'?
		do
			Result := action = activate
		end

	is_present: BOOLEAN
			-- Is `state' `present'?
		do
			Result := action = present
		end

	is_hide: BOOLEAN
			-- Is `state' `hide'?
		do
			Result := action = hide
		end

	is_deactivate: BOOLEAN
			-- Is `state' `deactivate'?
		do
			Result := action = deactivate
		end

	is_reactivate: BOOLEAN
			-- Is `state' `reactivate'?
		do
			Result := action = reactivate
		end

	is_destroy: BOOLEAN
			-- Is `state' `destroy'?
		do
			Result := action = destroy
		end

feature -- Element change

	set_action (a_action: like action)
			--
		require
			valid_state: is_type_valid (a_action)
		do
			action := a_action
		ensure
			action_set: action = a_action
		end

	set_present
			-- Set current action to `'.
		do
			action := present
		ensure
			is_present: is_present
		end

	set_hide
			-- Set current action to `hide'.
		do
			action := hide
		ensure
			is_hide: is_hide
		end

	set_deactivate
			-- Set current action to `deactivate'.
		do
			action := deactivate
		ensure
			is_deactivate: is_deactivate
		end

	set_reactivate
			-- Set current action to `reactivate'.
		do
			action := reactivate
		ensure
			is_reactivate: is_reactivate
		end

	set_destroy
			-- Set current action to `destroy'.
		do
			action := destroy
		ensure
			is_destroy: is_destroy
		end

feature -- Output

	action_out: STRING
			-- Printable representation of `action'
		do
			Result := action_type_as_string (action)
		end

feature frozen -- Type information

	action : INTEGER

invariant

	correct_action: is_type_valid(action)
			-- The type should always contain a valid value for representing the action to be executed on a view
end
