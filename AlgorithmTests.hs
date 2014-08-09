import Algorithm
import DataStructure
import Control.Exception
import Debug.Trace

main = do
 putStrLn("Begin Algorithm Tests")

 test "Sanity Test" $
  True

 let org = Vector3D (0,0,0)
     dir = Vector3D (0,0,1)
     ray = (org, normalize(dir))
     sphere = Sphere {sphere_loc = Vector3D(0,0,3), sphere_r = 1}
  in test "Intersect Hit" $ (intersect ray sphere) == 2

 let org = Vector3D (0,0,0)
     dir = Vector3D (0,2,1)
     ray = (org, normalize(dir))
     sphere = Sphere {sphere_loc = Vector3D(0,0,3), sphere_r = 1}
  in test "Intersect Miss" $ (intersect ray sphere) == -1

 let org = Vector3D (0,0,0)
     dir = Vector3D (0,0,-1)
  in test "generat_ray_dir" $ elem dir (generate_ray_dir org dir 3 3)

test :: String -> Bool -> IO ()
test s x = assert (x) (putStrLn $ " " ++ s ++ " [passed]")
