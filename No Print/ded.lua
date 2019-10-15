print = function(...) end								-- Disable prints
cat_print = function(...) end					-- CoreDebug function 
reload_and_compile = function(...) end		-- CoreDebug function
out = function(...) end						-- CoreDebug function
watch = function(...) end						-- CoreDebug function
cat_debug = function(...) end					-- CoreDebug function
cat_error = function(...) end					-- CoreDebug function
cat_stack_dump = function(...) end			-- CoreDebug function
cat_print_inspect = function(...) end			-- CoreDebug function
cat_debug_inspect = function(...) end			-- CoreDebug function
catprint_save = function(...) end				-- CoreDebug function
catprint_load = function(...) end				-- Ect
print_console_result = function(...) end
trace_ref = function(...) end
trace_ref_add_destroy_all = function(...) end
debug_pause = function(...) end
debug_pause_unit = function(...) end
compile_and_reload = function(...) end
class_name = function(...) end
full_class_name = function(...) end
error = function(...) end

if managers and managers.user and managers.savefile then
	managers.user:set_setting("max_streaming_chunk", 16384)
	managers.savefile:save_setting(true)
end