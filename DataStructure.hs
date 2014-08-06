module DataStructure (
 Vector3D(..),
 ViewPort,
 Color, Ray,
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


data ViewPort = ViewPort {
 viewPort_ray :: Ray,
 viewPort_with :: Float,
 viewPort_height :: Float,
 viewPort_resX :: Int,
 viewPort_resY :: Int
}

data Sphere = Sphere {
 sphere_loc :: Vector3D,
 sphere_r :: Float
}

data Plane = Plane {
}
