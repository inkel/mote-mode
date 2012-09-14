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

(defun mote-highlight-ruby (limit)
  "Highlight a Ruby expression."
  (when (re-search-forward "^[ \t]*%\\(.*\\)$" limit t)
    (mote-fontify-region-as-ruby (match-beginning 1) (match-end 1))))

(defun mote-highlight-assignment (limit)
  "Highlight a Ruby expression inside an assignment."
  (when (re-search-forward "{{\\(.*\\)}}" limit t)
    (mote-fontify-region-as-ruby (match-beginning 1) (match-end 1))))

(defun mote-fontify-region-as-ruby (beg end)
  "Use Ruby's font-lock variables to fontify region between BEG and END."
  (save-excursion
    (save-match-data
      (let ((font-lock-keywords ruby-font-lock-keywords)
            (font-lock-syntax-table ruby-font-lock-syntax-table)
            font-lock-keywords-only
            font-lock-extend-region-functions
            font-lock-keywords-case-fold-search)
        (font-lock-fontify-region beg end)))))

(defvar mote-font-lock-keywords
  '(("^[ \t]*%" 0 'mote-special-chars-face t)
    ("\\({{\\).*\\(}}\\)"
     (1 'mote-special-chars-face t)
     (2 'mote-special-chars-face t))
    (mote-highlight-assignment 1 font-lock-preprocessor-face)
    (mote-highlight-ruby 1 font-lock-preprocessor-face))
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
