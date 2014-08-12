{-
 Contains all the the data types used in the raytracer as well as 
 some simple functions.
-}
module DataStructure (
 Color(..), Ray,
 Viewport(..),
 Vector3D(..),
 Scene(..),
 Sphere(..),
 normalize,
 dot, cross, scalar_multi
) where 

fucked = error "Well that's fucked"

data Vector3D = Vector3D (Double, Double, Double) deriving (Show, Read)

normalize :: Vector3D -> Vector3D
normalize (Vector3D (0, 0, 0)) = fucked
normalize (Vector3D (x, y, z)) = Vector3D (x / l, y / l, z / l)
                      where l = sqrt $ x^2 + y^2 + z^2

dot :: Vector3D -> Vector3D -> Double
dot (Vector3D (x1,y1,z1)) (Vector3D (x2,y2,z2)) =
 x1*x2 + y1*y2 + z1*z2

scalar_multi :: Vector3D -> Double -> Vector3D
scalar_multi (Vector3D (x,y,z)) s = Vector3D (x*s, y*s, z*s)

cross :: Vector3D -> Vector3D -> Vector3D
cross (Vector3D (x1,y1,z1)) (Vector3D (x2,y2,z2)) =
 (Vector3D (y1*z2-z1*y2, z1*x2-x1*z2, x1*y2-y1*x2))

instance Eq Vector3D where (Vector3D x) == (Vector3D y) = x == y

instance Num Vector3D where
 (Vector3D (x1,y1,z1)) + (Vector3D (x2,y2,z2)) =
  Vector3D (x1+x2, y1+y2, z1+z2)
 (Vector3D (x1,y1,z1)) - (Vector3D (x2,y2,z2)) =
  Vector3D (x1-x2, y1-y2, z1-z2)
 v1 * v2 = cross v1 v2
 abs (Vector3D (x,y,z)) = (Vector3D (abs x,abs y,abs z))
 signum v1      = fucked
 fromInteger v1 = fucked
 
data Color = Color (Int, Int, Int) deriving (Show, Read)

instance Num Color where
 (Color (r1,g1,b1)) + (Color (r2,g2,b2)) =
  Color (min (r1+r2) 255, min (g1+g2) 255, min (b1+b2) 255)
 c1 * c2       = fucked
 abs c         = fucked
 signum c      = fucked
 fromInteger c = fucked

instance Eq Color where (Color x) == (Color y) = x == y

type Ray = (Vector3D, Vector3D)

data Sphere = Sphere {
 sphere_loc :: Vector3D,
 sphere_r :: Double,
 sphere_color_a :: Color,
 sphere_color_d :: Color,
 sphere_color_s :: Color
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
 scene_spheres  :: [Sphere],
 scene_lights   :: [Vector3D]
}
