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

(defface mote-begin-line-face '((t :inherit font-lock-keyword-face))
  "Face for Mote being line indicator."
  :group 'mote-faces)

(defface mote-comment-face '((t :inherit font-lock-comment-face))
  "Face for Mote comments."
  :group 'mote-faces)

(defface mote-line-face '((t :inherit font-lock-builtin-face))
  "Face for Mote Ruby lines"
  :group 'mote-faces)

(defface mote-assignment-face '((t :inherit font-lock-constant-face))
  "Face for Mote assignments."
  :group 'mote-faces)

(defvar mote-mode-font-lock-keywords
  '(("^ *%.*\\(#.*\\)" 1 'mote-comment-face)
    ("^ *%\\([^#]+\\)" 1 'mote-line-face)
    ("^ *%" . 'mote-begin-line-face)
    ("{{.+\\}}" . 'mote-assignment-face))
  "Additional syntax highlighting for Mote files.")

(define-minor-mode mote-mode
  "Toggle mote minor mode"
  :lighter " mote"
  :global nil
  :group 'mote
  (if mote-mode
      (font-lock-add-keywords nil mote-mode-font-lock-keywords t)
    (font-lock-remove-keywords nil mote-mode-font-lock-keywords))
  (font-lock-fontify-buffer))

(provide 'mote-mode)
