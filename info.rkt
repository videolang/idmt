#lang info

(define collection 'multi)

(define deps '(("base" "7.1")
               "draw-lib"
               "data-lib"
               "drracket-plugin-lib"
               "gui-lib"
               "images-lib"
               "math-lib"
               "syntax-color-lib"
               "wxme-lib"))
(define build-deps '("scribble-lib"
                     "racket-doc"))
(define version "0.0")
(define pkg-authors '(leif))
(define pkg-desc "Interactive Syntax")