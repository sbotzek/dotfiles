;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/" "~/org/log/" "~/org/projects/" "~/org/notes/" "~/org/notes/dev/" "~/org/notes/worldbuilding/"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Make C-c copy, and C-v paste
(defun paste-from-clipboard ()
  (interactive)
  (setq x-select-enable-clipboard t)
  (yank)
  (setq x-select-enable-clipboard nil))
(defun copy-to-clipboard()
  (interactive)
  (setq x-select-enable-clipboard t)
  (kill-ring-save (region-beginning) (region-end))
  (setq x-select-enable-clipboard nil))
(global-set-key (kbd "C-S-c") 'copy-to-clipboard)
(global-set-key (kbd "C-S-v") 'paste-from-clipboard)

;; configures browser for WSL
(when (and (eq system-type 'gnu/linux)
           (string-match
            "Linux.*Microsoft.*Linux"
            (shell-command-to-string "uname -a")))
  (setq
   browse-url-generic-program  "/mnt/c/Windows/System32/cmd.exe"
   browse-url-generic-args     '("/c" "start")
   browse-url-browser-function #'browse-url-generic))


;; copilot
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))


;; org mode - insert finished timestamp when TODO marked DONE
(setq org-log-done 'time)

;; org mode - open files in overview mode (everything folded)
(setq org-startup-folded 'overview)

(setq projectile-project-search-path '("~/dev/projects/" "~/dev/forks/" "~/dev/utils/" "~/dev/clones"))

(setq org-babel-clojure-backend 'cider)

;; org mode - tag groupings
(setq org-tag-alist '((:startgrouptag)
                      ("dev")
                      (:grouptags)
                      ("webdev")
                      ("java")
                      ("elixir")
                      ("golang")
                      ("rust")
                      ("javascript")
                      ("python")
                      ("mysql")
                      ("bug")
                      ("nodejs")
                      ("javascript")
                      ("common_lisp")
                      (:endgrouptag)

                      (:startgrouptag)
                      ("webdev")
                      (:grouptags)
                      ("phoenix")
                      ("spring")
                      ("reactjs")
                      (:endgrouptag)

                      (:startgrouptag)
                      ("learn")
                      (:grouptags)
                      ("book")
                      ("video")
                      ("article")
                      (:endgrouptag)

                      (:startgrouptag)
                      ("java")
                      (:grouptags)
                      ("spring")
                      ("jpa")
                      ("jooq")
                      ("hibernate")
                      (:endgrouptag)

                      (:startgrouptag)
                      ("elixir")
                      (:grouptags)
                      ("phoenix")
                      (:endgrouptag)

                      (:startgrouptag)
                      ("game")
                      (:grouptags)
                      ("herowars")
                      ("stellaris")
                      ("ffxiv")
                      ("ck2")
                      ("eu4")
                      (:endgrouptag)))
(after! org
	(setq org-todo-keywords
	      '((sequence "NEW(n)" ; brand new, needs to be processed into TODO, ICED, or KILLED
			  "TODO(t)" ; next thing to do
			  "STARTED(s)" ; i've started work on it
			  "FOLLOWUP(f)" ; followup means its paused, but not de-prioritized (iced)
			  "PAUSE(p)" ; paused means it was started, but was de-prioritized (iced)
			  "ICE(i)" ; to be done at a later date
			  "|"
			  "DONE(d)" ; it was done
			  "ABANDON(a)" ; cancelled, but work was done
			  "KILL(k)"))) ; cancelled, but no work done
	(setq org-todo-keyword-faces
	      '(("NEW" . "red")
		("TODO" . org-warning)
		("STARTED" . "yellow")
		("FOLLOWUP" . "yellow")
		("PAUSE" . "light blue")
		("ICE" . "light blue"))))

(treemacs-project-follow-mode t)
