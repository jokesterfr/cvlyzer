# CVlyzer

Generates your CV out of simple XML syntax

## Requirements

This package has been sucessfully tested on a Debian/Ubuntu Linux OS, everything should work fine assuming you installed these libraries:

```
# latex
apt install texlive texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-lang-all

# pdf
apt install pdflatex

# xslt
apt install xsltproc

# inkscape
apt install inkscape
```

node >= v6

## Build

```js
npm install
```

## Executing

A very simple `Makefile` is provided, modify the sources under `./src` and do:

	make

Magic happens, in your `./dest` file a surprise is waiting for you.

## Tidy HTML5

You need a recent version of tidy html5

On ubuntu <= 16.05 
```sh
sudo add-apt-repository ppa:jonathonf/backports
sudo apt update
sudo apt-install tidy
```

Check that:

```sh
$ tidy -v
HTML Tidy for Linux version 5.2.0
```

Sources:

 * http://www.html-tidy.org/documentation/
 * https://askubuntu.com/a/941872

## Credits

Thanks to Jason Blevins &lt;jrblevin@sdf.lonestar.org&gt; for his [LaTeX template](http://jblevins.org/projects/cv-template/).

Extra emojis come from https://github.com/mozilla/fxemoji, and are licensed under Apache License version 2.0.

## Licencing

GNU GPL V2 applies to this software, see [LICENCE](./LICENCSE-gnu-gpl-v2) file, my resume content, homepage and pictures are credited under [CC BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode).
