  <node pkg="grid_map_visualization" type="grid_map_visualization" name="grid_map_visualization" output="screen">
    <rosparam command="load" file="$(find elevation_mapping_cupy)/config/elevation_mapping.yaml" />
  </node>
  <node name="rviz" pkg="rviz" type="rviz" args="-d $(find elevation_mapping_cupy)/rviz/elevation_map_demo.rviz" />
  </node>
