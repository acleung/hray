module DataStructure (
 Color, Ray,
 Viewport(..),
 Vector3D(..),
 Scene(..),
 Sphere(..),
 normalize
) where 

data Vector3D = Vector3D (Float, Float, Float) deriving (Show, Read)

normalize :: Vector3D -> Vector3D
normalize (Vector3D (0, 0, 0)) = error "Well that's fucked"
normalize (Vector3D (x, y, z)) = Vector3D (x / l, y / l, z / l)
                      where l = sqrt $ x^2 + y^2 + z^2

instance Eq Vector3D where
 (Vector3D x) == (Vector3D y) = x == y

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
 viewport_loc :: Ray,
 viewport_dir :: Ray,
 viewport_resW :: Int,
 viewport_resH :: Int
}

data Scene = Scene {
 scene_viewport :: Viewport,
 scene_spheres :: [Sphere]
}
