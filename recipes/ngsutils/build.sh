mkdir -p $PREFIX/bin
mkdir -p $PREFIX/lib

for prog in fastq bam gtf bed; do
  mkdir -p $PREFIX/share/ngsutils/$prog
  mv $SRC_DIR/ngsutils/$prog/README $PREFIX/share/ngsutils/$prog
done
cp LICENSE VERSION $PREFIX/share/ngsutils/


sed -i .bak "3s~.*~DIR=$SP_DIR~g" $SRC_DIR/bin/ngsutils
sed -i .bak '9s~$DIR~$PREFIX/share~g' $SRC_DIR/bin/ngsutils
sed -i .bak "27s~.*~~g" $SRC_DIR/bin/ngsutils
sed -i .bak "28s~.*~~g" $SRC_DIR/bin/ngsutils
sed -i .bak "s~cat VERSION~cat $PREFIX/share/ngsutils/VERSION~g" $SRC_DIR/bin/ngsutils

sed -i .bak 's~exec "$DIR"/ngsutils/$SUBDIR/$action "$@"~exec python "$DIR"/ngsutils/$SUBDIR/$action "$@"~g' $SRC_DIR/bin/ngsutils

python setup.py install
