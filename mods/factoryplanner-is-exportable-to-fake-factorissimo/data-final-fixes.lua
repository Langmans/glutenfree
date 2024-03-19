local mod_prefix = 'fietff-'

local names_of_logistic_containers_with_request_slots = {}

for _, logistic_container in pairs(data.raw["logistic-container"]) do
  if logistic_container.logistic_mode == "requester" or logistic_container.logistic_mode == "buffer" then
    table.insert(names_of_logistic_containers_with_request_slots, logistic_container.name)
  end
end

for _, infinity_container in pairs(data.raw["infinity-container"]) do
  table.insert(names_of_logistic_containers_with_request_slots, infinity_container.name)

  -- infinity_container.gui_mode = 'none' -- non operable :|

  -- -- in case this breaks a custom description in your mod, please reach out and i'll try to incorporate it into the fallback ?
  -- infinity_container.localised_description = {"?", {"infinity-container.gui-mode-" .. (infinity_container.gui_mode or "all")}}
end

data.raw["container"][mod_prefix .. "container-1"].additional_pastable_entities = names_of_logistic_containers_with_request_slots
data.raw["container"][mod_prefix .. "container-2"].additional_pastable_entities = names_of_logistic_containers_with_request_slots
data.raw["container"][mod_prefix .. "container-3"].additional_pastable_entities = names_of_logistic_containers_with_request_slots

data:extend{
  {
    type = 'item-subgroup',
    name = mod_prefix .. 'fluid-port-in',

    group = 'other',
  },
  {
    type = 'item-subgroup',
    name = mod_prefix .. 'fluid-port-out',

    group = 'other',
  },
}

for _, fluid in pairs(data.raw['fluid']) do
  data:extend{
    {
      type = 'storage-tank',
      name = string.format(mod_prefix .. 'storage-tank-%s', fluid.name),
      localised_name = {"entity-name.fietff-storage-tank-fluidname", fluid.name},

      collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
      selection_box = {{-0.4, -0.4}, {0.4, 0.4}},
      selection_priority = 51,

      fluid_box = {
        production_type = "input-output",
        pipe_picture = util.empty_sprite(),
        pipe_covers = pipecoverspictures(),
        base_area = 1,
        base_level = -1,
        filter = fluid.name,
        pipe_connections = {{ type="input-output", position = {0, -1} }},
      },

      window_bounding_box = {{0, 0}, {0 , 0}},

      pictures = {
        picture = util.empty_sprite(),
        window_background = util.empty_sprite(),
        fluid_background = util.empty_sprite(),
        flow_sprite = util.empty_sprite(),
        gas_flow = util.empty_sprite(),
      },

      flow_length_in_ticks = 1,
      max_health = 100,

      -- flags = {"hide-alt-info"},
    }
  }
end

-- data.raw['storage-tank']['kr-fluid-storage-2'].fluid_box.filter = 'water'
