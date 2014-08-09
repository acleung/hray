import Algorithm
import DataStructure

main = do
  putStrLn(show(length(raytrace scene)))

  writeFile "output.txt" $ "size=" ++
    show(viewport_resW(scene_viewport scene)) ++ "x" ++ 
    show(viewport_resH(scene_viewport scene)) ++ "\n" ++
    (colors_to_text $ raytrace scene)
    
  where scene = (Scene (Viewport {
                 viewport_loc = Vector3D(0,0,1),
                 viewport_dir = Vector3D(0,0,-1),
                 viewport_up  = Vector3D(0,1,0),
                 viewport_resW = 800,
                 viewport_resH = 600
                })) [Sphere {sphere_loc = Vector3D(0,0,-4), sphere_r = 1.0}]

colors_to_text :: [Color] -> String
colors_to_text colors = foldl (\s c -> s ++ show c ++ "\n") "start\n" colors
