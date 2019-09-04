#!/bin/sh

md2html()
{
	pandoc --mathjax --template=$srcdir/template.html \
		$srcdir/$1.md -o $wwwdir/$1.html
}

srcdir=/home/pgdpinguin
wwwdir=/var/www/html/
remote=halle:/u/halle/qir/home_page/html-data/

echo -n 'Exporting to local server... '
rm $wwwdir/*

for srcfile in $srcdir/*.md; do
	md2html $(basename $srcfile .md)
done

cp $srcdir/*.css $wwwdir
chmod 644 $wwwdir/*
echo 'Done.'

echo -n 'Transferring to remote server... '
scp $wwwdir/* $remote
echo 'Done.'
