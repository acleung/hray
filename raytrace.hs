import Algorithm
import DataStructure
import System.IO
import qualified Data.ByteString.Char8 as BString

main = do
  putStrLn(show(length(raytrace scene)))

{-
  writeFile "output.txt" $ "size=" ++
    show(viewport_resW(scene_viewport scene)) ++ "x" ++ 
    show(viewport_resH(scene_viewport scene)) ++ "\n" ++
    (colors_to_text $ raytrace scene)
-}

{-
  writeFile "output.txt" $ "size=" ++
    show(viewport_resW(scene_viewport scene)) ++ "x" ++
    show(viewport_resH(scene_viewport scene)) ++ "\n"
  colors_to_file $ raytrace scene
-}

{-
  writeFile "output.txt" $ "size=" ++
    show(viewport_resW(scene_viewport scene)) ++ "x" ++ 
    show(viewport_resH(scene_viewport scene)) ++ "\n"
  appendFileLines "output.txt" (colors_to_text $ raytrace scene)
-}

  writeFile "output.txt" $ "size=" ++
    show(viewport_resW(scene_viewport scene)) ++ "x" ++
    show(viewport_resH(scene_viewport scene)) ++ "\n"
  BString.appendFile "output.txt" (BString.concat 
    (map (\color -> BString.pack (show(color) ++ "\n")) (raytrace scene)))

    
  where scene = (Scene (Viewport {
                 viewport_loc = Vector3D(0,0,1),
                 viewport_dir = Vector3D(0,0,-1),
                 viewport_up  = Vector3D(0,1,0),
                 viewport_resW = 800,
                 viewport_resH = 600
                })) [
                     Sphere {sphere_loc = Vector3D(0,0,-3),
                             sphere_r = 1.1,
                             sphere_color_a = (0,0,30),
                             sphere_color_d = (0,0,30),
                             sphere_color_s = (0,0,0)
                            }
                    ]

colors_to_text :: [Color] -> String
colors_to_text colors = foldl (\s c -> s ++ show c ++ "\n") "start\n" colors

colors_to_file :: [Color] -> IO ()
colors_to_file colors = do
 foldl (\s c -> s >> (appendFileLines "output.txt" (show(c) ++ "\n"))) (appendFileLines "output.txt" "start\n") colors

appendFileLines :: FilePath -> String -> IO ()
appendFileLines fileName text =
  withFile fileName AppendMode $ \h -> do
    hSetBuffering h LineBuffering
    hPutStr h text
