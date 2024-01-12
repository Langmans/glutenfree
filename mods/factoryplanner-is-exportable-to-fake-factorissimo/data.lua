local mod_prefix = 'fietff-'
local mod_path = '__factoryplanner-is-exportable-to-fake-factorissimo__'

local function create_container(config)
  local container = {
    type = 'container',
    name = mod_prefix .. 'container-' .. config.i,

    localised_name = {"entity-name.fietff-container-i", config.i},
  
    icon = string.format(mod_path .. '/graphics/icon/factory-%d.png', config.i),
    icon_size = 64,

    max_health = 500 + (1500 * config.i),
  
    collision_box = config.collision_box,
    selection_box = config.selection_box,
    vehicle_impact_sound = { filename = '__base__/sound/car-stone-impact.ogg', volume = 1.0 },
  
    inventory_size = 10 * config.i,
    enable_inventory_bar = false,
  
    flags = {
      'placeable-player',
      'player-creation',
      'hide-alt-info',
    },
  
    minable = {mining_time = 0.75 * config.i},
    
    picture = {
      layers = {
        {
          filename = string.format(mod_path .. '/graphics/factory/factory-%d-shadow.png', config.i),
          draw_as_shadow = true
        },
        {
          filename = string.format(mod_path .. '/graphics/factory/factory-%d-alt.png', config.i),
          shift = config.shift,
        }
      }
    }
  }

  for _, layer in ipairs(container.picture.layers) do
    for key, value in pairs(config.layers_inject) do
      layer[key] = value
    end
  end

  return container
end

local container_1 = create_container({
  i = 1,
  collision_box = {{-3.8, -3.8}, {3.8, 3.8}},
  selection_box = {{-3.8, -3.8}, {3.8, 3.8}},
  layers_inject = {
    width = 416,
    height = 320,
    shift = {1.5, 0},
  },
})

local container_2 = create_container({
  i = 2,
  collision_box = {{-5.8, -5.8}, {5.8, 5.8}},
  selection_box = {{-5.8, -5.8}, {5.8, 5.8}},
  layers_inject = {
    width = 544,
    height = 448,
    shift = {1.5, 0},
  }
})

local container_3 = create_container({
  i = 3,
  collision_box = {{-7.8, -7.8}, {7.8, 7.8}},
  selection_box = {{-7.8, -7.8}, {7.8, 7.8}},
  layers_inject = {
    width = 704,
    height = 608,
    shift = {2, -0.09375},
  }
})

data:extend{container_1, container_2, container_3}
