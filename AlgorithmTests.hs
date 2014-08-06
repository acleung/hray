import Algorithm
import DataStructure
import Control.Exception
import Debug.Trace

main = do
 putStrLn("Begin Algorithm Tests")

 test "Sanity Test" $
  True

 test "Simple Dot Product" $
  dot (Vector3D(1,2,3)) (Vector3D(4,5,6)) == 32

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

 putStrLn("End Algorithm Tests")

test :: String -> Bool -> IO ()
test s x = assert (x) (putStrLn $ " " ++ s ++ " [passed]")
