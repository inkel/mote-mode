;; mote-mode: a minor mode for editing Mote templates
;;
;; See https://github.com/soveran/mote
;;
;; Copyright 2012: Leandro López (inkel)
;;

(require 'font-lock)

(defgroup mote nil
  "Mote mode customization group")

(defgroup mote-faces nil
  "Faces used in Mote minor mode."
  :group 'mote
  :group 'faces)

(defface mote-comment-face '((t :inherit font-lock-comment-face))
  "Face for Mote comments."
  :group 'mote-faces)

(defface mote-special-chars-face '((t :inherit font-lock-constant-face
                                      :foreground "#eeaaaa"))
  "Face for Mote's special characters %, {{ }}."
  :group 'mote-faces)

(defface mote-ruby-code-face '((t :inherit font-lock-reference-face
                                  :weight bold))
  "Face for Ruby code inside Mote files."
  :group 'mote-faces)

(defface mote-assignment-face '((t :inherit font-lock-variable-name-face))
  "Face for assignments in Mote."
  :group 'mote-faces)

(defvar mote-font-lock-keywords
  '(("{{\\(.+\\)}}"
     (0 'mote-special-chars-face t)
     (1 'mote-assignment-face t))

    ("^\s*\\(%\\)\\(.*\\)"
     (1 'mote-special-chars-face t)
     (2 'mote-ruby-code-face t)
     )

    ("^\s*\\(%\\)\\(.*\\)\\(#.*\\)"
     (1 'mote-special-chars-face t)
     (2 'mote-ruby-code-face t)
     (3 'mote-comment-face t)))
  "Additional syntax highlighting for Mote files.")

(define-minor-mode mote-mode
  "Toggle mote minor mode"
  :lighter " mote"
  :global nil
  :group 'mote
  (if mote-mode
      (font-lock-add-keywords nil mote-font-lock-keywords)
    (font-lock-remove-keywords nil mote-font-lock-keywords))
  (font-lock-fontify-buffer))

(provide 'mote-mode)
