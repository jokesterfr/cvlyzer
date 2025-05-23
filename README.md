# CVlyzer

> **DISCLAIMER**: this project is archived. It was fun, but the perfect opposite of what could be called a KISS software 😅. Limiting the end result was not worse the journey of using old techs for fun. Finally a much better approach nowadays is to develop the web pages and export-to-pdf with a web browser. Simple as that. Feel free to reach my [porfolio project](https://github.com/jokesterfr/portfolio) or my website: https://clementdesiles.fr

Generates your CV as a PDF and Web page out of a simple XML.

## Requirements

This package has been sucessfully tested on a Debian system, everything should work fine assuming you installed these dependencies:

```
# latex
apt install texlive texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-lang-all

# pdf
apt install pdflatex

# xslt
apt install xsltproc

# inkscape
apt install inkscape

# Node.js
apt install nodejs
```

## Build

```js
npm install
```

## Executing

A very simple `Makefile` is provided, modify the sources under `./src` and do:

```
make
```

You will then find your documents under `./dist`.

## Tidy HTML5

You need a recent version of tidy html5

On ubuntu <= 16.05 
```sh
add-apt-repository ppa:jonathonf/backports
apt update
apt-install tidy
```

Check:

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

See [LICENCE](./LICENCSE.txt), my own resume content, homepage and pictures are credited under [CC BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode).
