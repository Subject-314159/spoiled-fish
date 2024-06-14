local sounds = require("__base__/prototypes/entity/sounds")
data:extend({{
    type = "capsule",
    name = "spoiled-fish",
    icon = "__spoiled-fish__/graphics/icons/spoiled-fish.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "raw-resource",
    capsule_action = {
        type = "use-on-self",
        attack_parameters = {
            type = "projectile",
            activation_type = "consume",
            ammo_category = "capsule",
            cooldown = 30,
            range = 0,
            ammo_type = {
                category = "capsule",
                target_type = "position",
                action = {
                    type = "direct",
                    action_delivery = {
                        type = "instant",
                        target_effects = {{
                            type = "play-sound",
                            sound = sounds.eat_fish
                        }}
                    }
                }
            }
        }
    },
    order = "h[spoiled-fish]",
    stack_size = 100
} --[[@as data.CapsulePrototype]] , {
    type = "recipe",
    name = "spoiled-fish",
    ingredients = {{"raw-fish", 1}},
    result = "spoiled-fish"
} --[[@as data.RecipePrototype]] , {
    type = "corpse",
    name = "turd",
    icon = "__spoiled-fish__/graphics/icons/turd.png",
    icon_size = 64,
    icon_mipmaps = 1,
    flags = {"placeable-neutral", "placeable-off-grid"},
    ground_patch_higher = {
        filename = "__spoiled-fish__/graphics/entities/turd.png",
        priority = "extra-high",
        width = 45,
        height = 32,
        frame_count = 1,
        variation_count = 1,
        scale = 0.75,
        hr_version = {
            filename = "__spoiled-fish__/graphics/entities/hr-turd.png",
            priority = "extra-high",
            width = 70,
            height = 50,
            frame_count = 1,
            variation_count = 1,
            scale = 0.33
        }
    }
} --[[@as data.CorpsePrototype]] , {
    type = "sound",
    name = "fart",
    filename = "__spoiled-fish__/sounds/fart.ogg"
}})
