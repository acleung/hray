
module Algorithm (
 intersect,
 dot
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
           viewport_resW = width, 
           viewport_resH = height }) =
  []
