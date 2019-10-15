core:module("CoreEnvironmentFeeder")

local ids_fog_max_range = Idstring("fog_max_range")
local ids_fog_min_range = Idstring("fog_min_range")
local ids_deferred = Idstring("deferred")
local ids_deferred_lighting = Idstring("deferred_lighting")
local ids_apply_ambient = Idstring("apply_ambient")
local ids_apply_ambient_id = Idstring("post_effect/deferred/deferred_lighting/apply_ambient"):key()
local zero_rotation = Rotation(0, 0, 0)
local zero_vector3 = Vector3(0, 0, 0)
local temp_rotation = Rotation(0, 0, 0)
local temp_vector3 = Vector3(0, 0, 0)

PostFogMinRangeFeeder = PostFogMinRangeFeeder or CoreClass.class(Feeder)
PostFogMinRangeFeeder.DATA_PATH_KEY = Idstring("post_effect/deferred/deferred_lighting/apply_ambient/fog_min_range"):key()
PostFogMinRangeFeeder.APPLY_GROUP_ID = Feeder.get_next_id()
PostFogMinRangeFeeder.IS_GLOBAL = nil
PostFogMinRangeFeeder.FILTER_CATEGORY = "Fog"
function PostFogMinRangeFeeder:apply(handler, viewport, scene)
	local material = handler:_get_post_processor_modifier_material(viewport, scene, ids_apply_ambient_id, ids_deferred, ids_deferred_lighting, ids_apply_ambient)

	material:set_variable(ids_fog_min_range, math.huge)
end

PostFogMaxRangeFeeder = PostFogMaxRangeFeeder or CoreClass.class(Feeder)
PostFogMaxRangeFeeder.DATA_PATH_KEY = Idstring("post_effect/deferred/deferred_lighting/apply_ambient/fog_max_range"):key()
PostFogMaxRangeFeeder.APPLY_GROUP_ID = Feeder.get_next_id()
PostFogMaxRangeFeeder.IS_GLOBAL = nil
PostFogMaxRangeFeeder.FILTER_CATEGORY = "Fog"
function PostFogMaxRangeFeeder:apply(handler, viewport, scene)
	local material = handler:_get_post_processor_modifier_material(viewport, scene, ids_apply_ambient_id, ids_deferred, ids_deferred_lighting, ids_apply_ambient)

	material:set_variable(ids_fog_max_range, math.huge)
	
end
