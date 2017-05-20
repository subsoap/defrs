components {
  id: "script"
  component: "/defrs/scripts/go_set_scale.script"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
  properties {
    id: "scale"
    value: "0.125,0.125,1.0"
    type: PROPERTY_TYPE_VECTOR3
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "tile_set: \"/defrs/assets/textures/misc/misc.atlas\"\n"
  "default_animation: \"pearl\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "blend_mode: BLEND_MODE_ALPHA\n"
  ""
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}
