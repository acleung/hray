
module Algorithm (
 intersect,
 dot,
 generate_ray_dir
) where 

import DataStructure

intersect :: Ray -> Sphere -> Float
intersect (ray_org, ray_dir) (Sphere {sphere_loc = sphere_org, sphere_r = r})
 | e < 0     = -1
 | otherwise = min t1 t2
 where a = ray_dir `dot` ray_dir
       b = 2 * ((ray_org - sphere_org) `dot` ray_dir)
       c = (ray_org - sphere_org) `dot` (ray_org - sphere_org) - r^2
       e = b^2-4*a*c
       t1 = ((-b) + sqrt(e))/2
       t2 = ((-b) - sqrt(e))/2

generate_light_rays :: Viewport -> [Ray]
generate_light_rays(
 Viewport {viewport_loc = loc,
           viewport_dir = dir, 
           viewport_up = up, 
           viewport_resW = width, 
           viewport_resH = height }) =
  [] where right = normalize(cross dir up)
           x_ratio = 1.0 / toRational width
           y_ratio = 1.0 / toRational height

generate_ray_dir :: Vector3D -> Vector3D -> Int -> Int -> [Vector3D]
generate_ray_dir org dir width height
 = [normalize(dir + (Vector3D(fromIntegral(x)*x_ratio,fromIntegral(y)*y_ratio,0))) |
                                    x <-[x_start..x_end],
                                    y <-[y_start..y_end]]
 where x_ratio = 1.0 / w
       y_ratio = 1.0 / h
       w = fromIntegral width
       h = fromIntegral height
       x_start = -ceiling(w/2) :: Int
       x_end   = floor(w/2) :: Int
       y_start = -ceiling(h/2) :: Int
       y_end   = floor(h/2) :: Int
      
