#lang s-exp "../lang.rkt"

(require racket/splicing
         "editor.rkt"
         (for-syntax racket/base))

(splicing-syntax-parameterize ([current-editor-lang "../lang.rkt"]
                               [current-editor-base '(submod "../base.rkt" editor)])
  (require (for-editor)
         racket/class
         racket/serialize
         (for-editor "context.rkt"
                     (prefix-in gui: racket/gui/base)
                     racket/async-channel))

(define-editor picker$ window$
  (super-new)
  (new label$ [parent this]
       [text "Select Editor"])

  (init-field result-channel
              frame)

  (define mod-row (new horizontal-block$ [parent this]))
  (define editor-row (new horizontal-block$ [parent this]))
  (define confirm-row (new horizontal-block$ [parent this]))

  (new label$ [parent mod-row]
       [text "Module:"])
  (new label$ [parent editor-row]
       [text "Editor:"])
  (new button$ [parent confirm-row]
       [label (new label$ [text "Cancel"])]
       [callback (λ (this event)
                   (send this show #f))])
  (new button$ [parent confirm-row]
       [label (new label$ [text "OK"])]
       [callback (λ (b event)
                   (async-channel-put result-channel
                                      (cons (send mod-name get-text)
                                            (send editor-name get-text)))
                   (send this show #f)
                   (send frame show #f))])

  (define mod-name (new field$ [parent mod-row]))
  (define editor-name (new field$ [parent editor-row])))

(begin-for-editor
  (define res (make-async-channel))
  (define f (new gui:frame% [label "Test"]))
  (define p (new picker$
                 [result-channel res]
                 [frame f]))
  (new editor-canvas% [parent f]
       [editor p])
  (send f show #t)
  (thread
   (λ ()
     (displayln (async-channel-get res))))))