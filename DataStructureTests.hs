import DataStructure
import Control.Exception

main = do
 putStrLn("Begin DataStructure Tests")

 test "Sanity Test" $
  True

 test "Vector3D Eq" $
  Vector3D(1,1,1) == Vector3D(1,1,1)

 test "Simple Dot Product" $
  dot (Vector3D(1,2,3)) (Vector3D(4,5,6)) == 32

 test "Simple Dot Product" $
  cross (Vector3D(0,0,-1)) (Vector3D(0,1,0)) == Vector3D(1,0,0)

 test "Simple Dot Product" $
  cross (Vector3D(1,2,3)) (Vector3D(4,5,6)) == Vector3D(-3,6,-3)

 test "Normalize 1,1,1," $
  normalize(Vector3D(1,1,1))==Vector3D(1/sqrt(3), 1/sqrt(3), 1/sqrt(3))

 test "Normalize Identity" $
  normalize(normalize(Vector3D(1,0,0))) == Vector3D((1,0,0))

 let v1 = Vector3D (1,2,3)
     v2 = Vector3D (4,5,6)
     v3 = Vector3D (5,7,9)
  in test "Vector3D Add" $ v1 + v2 == v3

test :: String -> Bool -> IO ()
test s x = assert (x) (putStrLn $ " " ++ s ++ " [passed]")
