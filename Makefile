default: jpg

jpg: raytrace
	./raytrace +RTS -K100m -H1200m -sstderr -RTS && ./makejpg.pl output.txt > out.jpg

raytrace: raytrace.hs Algorithm.hs DataStructure.hs
	ghc -O2 -fexcess-precision -optc-O3 -optc-ffast-math -no-recomp -rtsopts raytrace.hs -o raytrace 

clean:
	rm -fr *.hi *.o *.jpg output.* raytrace
