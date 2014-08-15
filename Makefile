default: jpg

jpg: raytrace
	./raytrace +RTS -p -K100m -H1200m -sstderr -RTS && ./makejpg.pl output.txt > out.jpg

raytrace: raytrace.hs Algorithm.hs DataStructure.hs
	ghc -prof -fprof-auto -O2 -fexcess-precision -optc-O3 -optc-ffast-math -no-recomp -rtsopts -fbreak-on-exception raytrace.hs -o raytrace 

clean:
	rm -fr *.hi *.o *.jpg output.* raytrace raytrace.prof
