{-
 Contains all the the data types used in the raytracer as well as 
 some simple functions.
-}
module DataStructure (
 Color, Ray,
 Viewport(..),
 Vector3D(..),
 Scene(..),
 Sphere(..),
 normalize,
 dot, cross
) where 

data Vector3D = Vector3D (Float, Float, Float) deriving (Show, Read)

normalize :: Vector3D -> Vector3D
normalize (Vector3D (0, 0, 0)) = error "Well that's fucked"
normalize (Vector3D (x, y, z)) = Vector3D (x / l, y / l, z / l)
                      where l = sqrt $ x^2 + y^2 + z^2

dot :: Vector3D -> Vector3D -> Float
dot (Vector3D (x1,y1,z1)) (Vector3D (x2,y2,z2)) =
 x1*x2 + y1*y2 + z1*z2

cross :: Vector3D -> Vector3D -> Vector3D
cross (Vector3D (x1,y1,z1)) (Vector3D (x2,y2,z2)) =
 (Vector3D (y1*z2-z1*y2, z1*x2-x1*z2, x1*y2-y1*x2))

instance Eq Vector3D where (Vector3D x) == (Vector3D y) = x == y

instance Num Vector3D where
 (Vector3D (x1,y1,z1)) + (Vector3D (x2,y2,z2)) =
  Vector3D (x1+x2, y1+y2, z1+z2)
 (Vector3D (x1,y1,z1)) - (Vector3D (x2,y2,z2)) =
  Vector3D (x1-x2, y1-y2, z1-z2)
 
type Color = (Int, Int, Int)
type Ray = (Vector3D, Vector3D)

data Sphere = Sphere {
 sphere_loc :: Vector3D,
 sphere_r :: Float
}

data Plane = Plane {

}

data Viewport = Viewport {
 -- Location of the Camera
 viewport_loc :: Vector3D,
 -- Where the camera is facing
 viewport_dir :: Vector3D,
 -- The up director of the camera.
 viewport_up  :: Vector3D,
 -- The resolution.
 viewport_resW :: Int,
 viewport_resH :: Int
}

{-
 This is the input of the raytracer.
-}
data Scene = Scene {
 scene_viewport :: Viewport,
 scene_spheres :: [Sphere]
}
