note
	description: "Summary description for {CLOSE_SET_EXPRESSION_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLOSE_SET_EXPRESSION_VISITOR

inherit
	EXPRESSION_VISITOR_INTERFACE
	redefine dispatch end

create
	make

feature
	make
		do
			set_found := false
			set_closed := false
			pending_inputs := false
			in_set := false
			create set_stack.make
		end
feature

	set_stack: LINKED_STACK[SET_EXPRESSION]
	dispatch(expression: EXPRESSION_INTERFACE)
		do
			precursor(expression)
			if not set_found then
				(create {SET_ENUMERATION_NOT_SPECIFIED_EXCEPTION}).raise
			else
				if not set_closed then
					(create {SET_ENUMERATION_NOT_COMPLETE_EXCEPTION}.make).raise
				end
			end
		end

	visit_constant_expression(expression: CONSTANT_EXPRESSION)
		do end

	visit_binary_expression(expression: BINARY_EXPRESSION)
		do
			expression.left.accept (Current)
			expression.right.accept (Current)
		end

	visit_unary_expression(expression: UNARY_EXPRESSION)
		do
			expression.exp.accept (Current)
		end

	visit_nil_expression(expression: NIL_EXPRESSION)
		do
			if not set_stack.is_empty then
				pending_inputs := true
			end
		end

	visit_set_expression(expression: SET_EXPRESSION)
		do
			if not set_closed and not expression.closed then
				set_found := true
				stack_push (expression)
				across expression as iterator
				loop
					if not set_closed then
						iterator.item.accept (Current)
					end
				end
				(agent stack_pop).call
				if not pending_inputs and not set_closed and expression.can_close then
					set_closed := true
					expression.close
				end
			end
		end
feature
	set_found: BOOLEAN
	set_closed: BOOLEAN
	in_set: BOOLEAN
	pending_inputs: BOOLEAN

feature
	stack_push (item: like set_stack.item)
		do
			set_stack.put (item)
		end

	stack_pop: like set_stack.item
		do
			Result := set_stack.item
			set_stack.remove
		end


end
