class NodeMaterialBase extends NodeBase
  set_fields: =>
    super
    @ob = false
    webgl_materials_node[webgl_materials_node.length] = this
    @rack.addFields
      inputs:
        "opacity": 1
        "transparent": false
        "depthTest": true
        #"blending": THREE.NormalBlending
        "alphaTest": 0
        "polygonOffset": false
        "polygonOffsetFactor": 0
        "polygonOffsetUnits": 0
  
  compute: =>
    @apply_fields_to_val(@rack.node_fields.inputs, @ob)
    @rack.set("out", @ob)

class nodes.types.Materials.MeshBasicMaterial extends NodeMaterialBase
  set_fields: =>
    super
    @ob = new THREE.MeshBasicMaterial({color: 0xff0000})
    @rack.addFields
      inputs:
        "color": {type: "Color", val: new THREE.Color(1, 0, 0)}
        "map": {type: "Any", val: false}
        "reflectivity": 1
        "refractionRatio": 0.98
        "wireframe": false
        "wireframeLinecap": 1
        "vertexColors": false
        "skinning": false
      outputs:
        "out": {type: "Any", val: @ob}
    @vars_rebuild_shader_on_change = ["transparent", "depthTest", "map"]
    @material_cache = @create_cache_object(@vars_rebuild_shader_on_change)
  
  compute: =>
    if @input_value_has_changed(@vars_rebuild_shader_on_change)
      @ob = new THREE.MeshBasicMaterial({color: 0xff0000})
    @apply_fields_to_val(@rack.node_fields.inputs, @ob)
    @material_cache = @create_cache_object(@vars_rebuild_shader_on_change)
    @rack.set("out", @ob)

class nodes.types.Materials.MeshLambertMaterial extends NodeMaterialBase
  set_fields: =>
    super
    @ob = new THREE.MeshLambertMaterial({color: 0xff0000})
    @rack.addFields
      inputs:
        "color": {type: "Color", val: new THREE.Color(1, 0, 0)}
        "reflectivity": 1
        "refractionRatio": 0.98
        "wireframe": false
        "vertexColors": {type: "Any", val: false}
        "skinning": false
      outputs:
        "out": {type: "Any", val: @ob}
    @vars_rebuild_shader_on_change = ["transparent", "depthTest"]
    @material_cache = @create_cache_object(@vars_rebuild_shader_on_change)
  
  compute: =>
    if @input_value_has_changed(@vars_rebuild_shader_on_change)
      @ob = new THREE.MeshLambertMaterial({color: 0xff0000})
    @apply_fields_to_val(@rack.node_fields.inputs, @ob)
    @material_cache = @create_cache_object(@vars_rebuild_shader_on_change)
    @rack.set("out", @ob)
