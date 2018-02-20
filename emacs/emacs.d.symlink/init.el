(setq inhibit-startup-screen t
  initial-scratch-message ";; ready\n\n"
  package-archives '(("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/")
                    ("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "https://orgmode.org/elpa/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'package)
(require 'use-package)

(setq evil-want-C-i-jump nil)
(use-package evil
  :ensure t
  :init
  (evil-mode 1))

(use-package cmake-ide
  :ensure t
  :init
  (cmake-ide-setup))

(use-package rtags
  :ensure t)

(use-package powerline-evil
  :ensure t)

(use-package powerline
  :ensure t
  :init
  (powerline-default-theme))

;; Editor
;; (blink-cursor-mode 0)
;; (setq-default show-trailing-whitespace t)
;; (setq-default word-wrap t)
;; (setq-default fill-column 80)
;; (setq-default c-basic-indent 2)
;; (setq-default tab-width 2)
;; (setq-default indent-tabs-mode nil)

(define-key lisp-interaction-mode-map (kbd "<C-return>") 'eval-last-sexp)

(when (window-system)
  (set-default-font "Source Code Pro")
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(package-selected-packages (quote (evil-mode use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
