module Algorithm (
 raytrace,
 intersect,
 dot,
 viewport_to_primary_rays
) where 

import DataStructure
import Debug.Trace

color_empty = Color(0,0,0)

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
raytrace scene = map (compute_color_from_multiple_rays scene) p_rays
 where p_rays = (viewport_to_primary_rays (scene_viewport scene))

compute_color_from_multiple_rays :: Scene -> Ray -> Color 
compute_color_from_multiple_rays scene ray = average_color colors
 where colors = map (compute_color_from_ray scene) rays
       rays = (compute_anti_alias_rays scene ray)

compute_anti_alias_rays :: Scene -> Ray -> [Ray]
compute_anti_alias_rays scene ray = rays
 where width  = viewport_resW $ scene_viewport scene
       height = viewport_resH $ scene_viewport scene
       w = fromIntegral $ 2 * width + 1
       h = fromIntegral $ 2 * height + 1
       screen_w = 1.0 / w
       screen_h = 1.0 / h
       screensize  = min screen_w screen_h
       rays = generate_primary_rays screensize ray 1 1
       
compute_color_from_ray :: Scene -> Ray -> Color
compute_color_from_ray scene ray = compute_color_from_closest_sphere ray (compute_closest_sphere ray (scene_spheres scene))

-- It's the location of the intersection.
compute_color_from_closest_sphere :: Ray -> [(Vector3D, Sphere)] -> Color
compute_color_from_closest_sphere r intersection
 | null intersection = color_empty
 | otherwise         = color_sum
 where color_ambient  = phong_shading_ambient  r (last intersection)
       color_diffuse  = phong_shading_diffuse  r (last intersection)
       color_specular = phong_shading_specular r (last intersection)
       color_sum      = color_ambient + color_diffuse 
       
phong_shading_ambient :: Ray -> (Vector3D, Sphere) -> Color
phong_shading_ambient _ (Vector3D loc, sphere) = sphere_color_a sphere

phong_shading_diffuse :: Ray -> (Vector3D, Sphere) -> Color
phong_shading_diffuse _ (loc, Sphere {sphere_color_d = (Color (r,g,b)), sphere_loc= sloc}) 
 | factor > 0 = Color (floor((fromIntegral r) * factor), floor((fromIntegral g) * factor), floor((fromIntegral b) * factor))
 | otherwise  = color_empty
  where factor = 0.1 * dot normal light :: Double
        normal = normalize (loc - sloc)
        light  = Vector3D (99,99,99)

phong_shading_specular :: Ray -> (Vector3D, Sphere) -> Color
phong_shading_specular (ray_loc, ray_dir) (loc, Sphere {sphere_color_s = (Color (r,g,b)), sphere_loc= sloc})
 | factor > 0 = Color (floor((fromIntegral r) * factor), floor((fromIntegral g) * factor), floor((fromIntegral b) * factor))
 | otherwise  = color_empty
 where refection_dir = normalize ((scalar_multi normal (2 * (dot normal ray_dir))) - ray_dir)
       normal = normalize (loc - sloc)
       factor = 0.1 * ((dot refection_dir (Vector3D (99,99,99))) ^ 3)

compute_closest_sphere :: Ray -> [Sphere] -> [(Vector3D, Sphere)]
compute_closest_sphere ray spheres = foldl (pick_closer_sphere ray) [] spheres

pick_closer_sphere :: Ray -> [(Vector3D, Sphere)] -> Sphere -> [(Vector3D, Sphere)]
pick_closer_sphere ray list new
 | null list = if new_dist > 0 then [(new_loc, new)] else []
 | new_dist > 0 && new_dist < intersect ray (snd (last list)) = [(new_loc, new)]
 | otherwise = [last list]
 where new_dist = intersect ray new
       new_loc  = (scalar_multi (snd ray) new_dist) + (fst ray)

viewport_to_primary_rays :: Viewport -> [Ray]
viewport_to_primary_rays(
 Viewport {viewport_loc = loc,
           viewport_dir = dir, 
           viewport_up = up, 
           viewport_resW = width, 
           viewport_resH = height }) =
  generate_primary_rays 1.0 (loc,dir) width height

generate_primary_rays :: Double -> Ray -> Int -> Int -> [Ray]
generate_primary_rays screensize (org,dir) width height =
 map (\new_dir -> (org, new_dir)) dirs
 where x_ratio = screensize / w
       y_ratio = screensize / h
       ratio  = min x_ratio y_ratio
       w = fromIntegral width
       h = fromIntegral height
       x_start = -ceiling(w/2) :: Int
       x_end   =  floor(w/2) - 1:: Int
       y_start = -ceiling(h/2) :: Int
       y_end   =  floor(h/2) - 1:: Int
       local_dirs = [(x,y,0) | y <-[y_start..y_end], x <-[x_start..x_end]]
       dirs = map (\(x,y,z) -> normalize (dir + (Vector3D(fromIntegral(x)*ratio,fromIntegral(-y)*ratio,0)))) local_dirs
