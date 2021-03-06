import Algorithm
import DataStructure
import System.IO
import qualified Data.ByteString.Char8 as BString

file = "output.txt"

main = do
  putStrLn(show(length colors))
  writeFile "output.txt" $ "size=" ++
    show(viewport_resW(scene_viewport scene)) ++ "x" ++
    show(viewport_resH(scene_viewport scene)) ++ "\n"
  BString.appendFile "output.txt" (BString.concat 
    (map (\color -> BString.pack (show(color) ++ "\n")) colors))

  where scene = Scene (
                 Viewport {
                  viewport_loc = Vector3D(0,0,1),
                  viewport_dir = Vector3D(0,0,-1),
                  viewport_up  = Vector3D(0,1,0),
                  viewport_resW = 300,
                  viewport_resH = 300 
                 })
                 (Shapes [
                  Sphere {sphere_loc = Vector3D(0,0,-2),
                          sphere_r = 0.2,
                          sphere_color_a = Color (0,0,50),
                          sphere_color_d = Color (0,0,30),
                          sphere_color_s = Color (1,1,1)
                         },
                  Sphere {sphere_loc = Vector3D(-1,-1,-3),
                          sphere_r = 1.2,
                          sphere_color_a = Color (50,0,0),
                          sphere_color_d = Color (30,0,0),
                          sphere_color_s = Color (1,1,1)
                         },
                  Sphere {sphere_loc = Vector3D(-1,1,-3),
                          sphere_r = 1.2,
                          sphere_color_a = Color (0,50,0),
                          sphere_color_d = Color (0,30,0),
                          sphere_color_s = Color (1,1,1)
                         }
                 ])
                 {-Light-} [Vector3D (1.25,1.25,9)]
                 2
        colors = raytrace scene
