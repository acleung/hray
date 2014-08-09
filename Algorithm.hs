
module Algorithm (
 raytrace,
 intersect,
 dot,
 generate_primary_ray_dirs,
 viewport_to_primary_rays
) where 

import DataStructure

intersect :: Ray -> Sphere -> Double
intersect (ray_org, ray_dir) (Sphere {sphere_loc = sphere_org, sphere_r = r})
 | e < 0     = -1
 | otherwise = min t1 t2
 where a = ray_dir `dot` ray_dir :: Double
       b = 2 * ((ray_org - sphere_org) `dot` ray_dir) :: Double
       c = (ray_org - sphere_org) `dot` (ray_org - sphere_org) - r^2 :: Double
       e = b^2-4*a*c :: Double
       t1 = ((-b) + sqrt(e))/2.0 :: Double
       t2 = ((-b) - sqrt(e))/2.0 :: Double

raytrace :: Scene -> [Color]
raytrace s = map (\r -> compute_color_from_closest_sphere (compute_closest_sphere r (scene_spheres s))) (viewport_to_primary_rays (scene_viewport s))

compute_color_from_closest_sphere :: [Sphere] -> Color
compute_color_from_closest_sphere sphere = if null sphere then (0,0,0) else (0,0,255)

compute_closest_sphere :: Ray -> [Sphere] -> [Sphere]
compute_closest_sphere ray spheres = foldl (pick_closer_sphere ray) [] spheres

pick_closer_sphere :: Ray -> [Sphere] -> Sphere -> [Sphere]
pick_closer_sphere ray list new
 | null list = if new_dist > 0 then [new] else []
 | otherwise = let old = last list in if new_dist < intersect ray old then [new] else [old]
 where new_dist = intersect ray new

viewport_to_primary_rays :: Viewport -> [Ray]
viewport_to_primary_rays(
 Viewport {viewport_loc = loc,
           viewport_dir = dir, 
           viewport_up = up, 
           viewport_resW = width, 
           viewport_resH = height }) =
  generate_primary_rays loc (generate_primary_ray_dirs loc dir width height)

generate_primary_rays :: Vector3D -> [Vector3D] -> [Ray]
generate_primary_rays org ray_dirs = map (\x -> (org,x)) ray_dirs

generate_primary_ray_dirs :: Vector3D -> Vector3D -> Int -> Int -> [Vector3D]
generate_primary_ray_dirs org dir width height
 = [normalize(dir + (Vector3D(fromIntegral(x)*x_ratio,fromIntegral(y)*(-y_ratio),0))) |
                                    x <-[x_start..x_end],
                                    y <-[y_start..y_end]]
 where x_ratio = 1.0 / w
       y_ratio = 1.0 / h
       w = fromIntegral width
       h = fromIntegral height
       x_start = -ceiling(w/2) :: Int
       x_end   = floor(w/2) - 1:: Int
       y_start = -ceiling(h/2) :: Int
       y_end   = floor(h/2) - 1:: Int
      
