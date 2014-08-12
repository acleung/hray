import Algorithm
import DataStructure
import System.IO
import qualified Data.ByteString.Char8 as BString

file = "output.txt"

main = do
  putStrLn(show(length(raytrace scene)))
  writeFile "output.txt" $ "size=" ++
    show(viewport_resW(scene_viewport scene)) ++ "x" ++
    show(viewport_resH(scene_viewport scene)) ++ "\n"
  BString.appendFile "output.txt" (BString.concat 
    (map (\color -> BString.pack (show(color) ++ "\n")) (raytrace scene)))

  where scene = Scene (
                 Viewport {
                  viewport_loc = Vector3D(0,0,1),
                  viewport_dir = Vector3D(0,0,-1),
                  viewport_up  = Vector3D(0,1,0),
                  viewport_resW = 800,
                  viewport_resH = 600
                 })
                 [
                  Sphere {sphere_loc = Vector3D(0,0,-2),
                          sphere_r = 0.2,
                          sphere_color_a = Color (0,0,60),
                          sphere_color_d = Color (0,0,10),
                          sphere_color_s = Color (0,0,0)
                         },
                  Sphere {sphere_loc = Vector3D(0,0,-4),
                          sphere_r = 1.2,
                          sphere_color_a = Color (0,0,60),
                          sphere_color_d = Color (0,0,10),
                          sphere_color_s = Color (0,0,6)
                         }
                 ]
                 [
                  Vector3D (99,99,99)
                 ]
