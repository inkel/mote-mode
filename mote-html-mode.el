(load-file "mote-mode.el")

(defgroup mote-html-faces nil
  "Faces used in Mote HTML mode."
  :group 'mote-faces
  :group 'faces)

(defface mote-html-tag-face '((t :inherit font-lock-builtin-face))
  "Face for HTML tags in Mote mode."
  :group 'mote-html-faces)

(defface mote-html-tag-name-face '((t :inherit mote-html-tag-face
                                      :slant italic))
  "Face for HTML tags names in Mote mode."
  :group 'mote-html-faces)

(defvar mote-html-font-lock-keywords
  (append '(("<\\(\\<[^ >]+\\)>?"
             (0 'mote-html-tag-face t)
             (1 'mote-html-tag-name-face t))
            ("</\\([^>]+\\)>"
             (0 'mote-html-tag-face t)
             (1 'mote-html-tag-name-face t))
            ("<![dD][oO][cC][tT][yY][pP][eE] .+>" . font-lock-constant-face))
            mote-font-lock-keywords))

(define-derived-mode mote-html-mode text-mode
  "HTML+Mote"
  "Major mode for editing HTML files with Mote support."
  (setq font-lock-defaults '((mote-html-font-lock-keywords))))

(provide 'mote-html-mode)
