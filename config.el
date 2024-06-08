;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Roshan Nair"
      user-mail-address "roshan.nair.007@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-ayu-dark)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org"
      org-roam-directory "~/Documents/org")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;(add-hook! 'visual-line-mode-hook #'visual-fill-column-mode)
;;(setq-default visual-fill-column-center-text t)

;; confirm-kill-emacs is non-nil by default. The doom-quit module only adds silly confirmation messages to it. To disable it completely
(setq confirm-kill-emacs nil)

;; Org-Roam configuration
(use-package! org-roam
  :custom
  (org-roam-directory (file-truename "/home/roshan/Documents/org"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))
  ;; If using org-roam-protocol
  ;; (require 'org-roam-protocol))

;;;; check platformio files
(add-hook! c++-mode
        (setq flycheck-clang-include-path
                         (list (expand-file-name "/home/roshan/.platformio/packages/framework-arduinoespressif32/cores/esp32/"))))
;; hunspell for flyspell
;;(setenv "DICPATH" "/usr/share/hunspell")
(setq ispell-program-name "hunspell")
(setq ispell-local-dictionary "en_IN")
(setq ispell-local-dictionary-alist
      '(("en_IN" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil nil nil utf-8)))

;; config for org-mordern package
(use-package! org-modern
  :hook (org-mode . global-org-modern-mode)
  :config
  (setq org-modern-label-border 0.3))

;; Attempt at changing the font color of org-mode headings
 (custom-set-faces
 '(org-level-1 ((t (:foreground "#ff8000"))))    ;; Orange
 '(org-level-2 ((t (:foreground "#ffdd99"))))    ;;#a7963f #e6c000 #ffff66 #ffd480;;yellow
 '(org-level-3 ((t (:foreground "#ba752f"))))    ;; Brown? #3399ff #007fff
 '(org-level-4 ((t (:foreground "#ff8000"))))    ;; Orange
 )


;; org-xournalpp configs
(use-package! org-xournalpp
  :config
  (add-hook 'org-mode-hook 'org-xournalpp-mode))

;; Capture templates for org-roam
(setq org-roam-capture-templates
      '(("m" "main" plain
         "%?"
         :if-new (file+head "main/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("r" "reference" plain "%?"
         :if-new
         (file+head "reference/${slug}.org" "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("t" "tags" plain "%?"
         :if-new
         (file+head "tags/${title}.org" "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("a" "accumulation" plain "%?"
         :if-new
         (file+head "accumulation/${slug}.org" "#+title: ${title}\n#+filetags: :accumulation:\n")
         :immediate-finish t
         :unnarrowed t)
         ("o" "office" plain "%?"
         :if-new
         (file+head "office/${slug}.org" "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)))

;; Creating the property “type” on my nodes.
(cl-defmethod org-roam-node-type ((node org-roam-node))
  "Return the TYPE of NODE."
  (condition-case nil
      (file-name-nondirectory
       (directory-file-name
        (file-name-directory
         (file-relative-name (org-roam-node-file node) org-roam-directory))))
    (error "")))

;; Modifying the display template to show the node “type”
(setq org-roam-node-display-template
      (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

;; org-capture template for random notes
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Documents/org/gtd/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/Documents/org/journal/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("s" "Slipbox" entry (file+datetree "~/Documents/org/random/notes.org")
         "* %?\n")
        ))
;(setq org-capture
      ;; other capture templates
;      ("s" "Slipbox" entry  (file "./braindump/inbox.org")
;       "* %?\n"))

;;(defun jethro/org-capture-slipbox ()
;;  (interactive)
;;  (org-capture nil "s"))

;; Change font size for emacs
(setq doom-font (font-spec :size 15))

;; gptel configuration to help with ollama2 or gpt4-all
(gptel-make-ollama
 "Ollama"                               ;Any name of your choosing
 :host "localhost:11434"                ;Where it's running
 :models '("llama2:latest")            ;Installed models
 :stream t)                             ;Stream responses
