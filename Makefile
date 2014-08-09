default: jpg

jpg: raytrace
	./raytrace && ./makejpg.pl output.txt > out.jpg

raytrace: raytrace.hs Algorithm.hs DataStructure.hs
	ghc -O2 raytrace.hs -o raytrace 

clean:
	rm -fr *.hi *.o *.jpg output.* raytrace
