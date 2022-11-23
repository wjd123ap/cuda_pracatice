import numpy as np
'''
max_fps = -1
map_fps_unique=[2,3,5]
map_fps=[5,2,3]
map_layers_all=[]
map_layers=[['elevation',  'variance'],['elevation'],['min_filter', 'smooth', 'inpaint', 'upper_bound']]
for fps in map_fps_unique:
  indices=[]
  if (fps>=max_fps):
    max_fps = fps
    map_layers_all=[]
  for i in range(len(map_fps)):
    if map_fps[i]== fps:
      indices.append(i)
      if fps>= max_fps:
        for layer in map_layers[i]:
          map_layers_all.append(layer)

  for i in indices:
    print(i)
  print(map_layers_all)

raw_points=[[np.inf,np.inf,np.inf],[0.4,0.5,0.8],[np.NAN,np.NAN,np.NAN],[0.05,0.5,0.55]]
raw_points = np.asarray(raw_points)

raw_points = raw_points[np.isfinite(raw_points).any(axis=1)]
print(raw_points)
'''
asdf=np.zeros((2,20,20))

