make clean
if [ ! -d "out" ]; then
 mkdir out
fi
cp raytrace.hs raytrace.hs.bak
for i in `seq -w 1 1000`; do
 value=`echo "$i * 0.01 + 1" | bc -l`
 echo $value
 light="                 {-Light-} [Vector3D ($value,$value,9)]"
 cat raytrace.hs | sed -e "s/.*Light.*/$light/" > raytrace.hs.new
 mv raytrace.hs.new raytrace.hs
 make
 mv out.jpg "out/out_$i.gif"
done

rm raytrace.hs.bak
