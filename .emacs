;; line numbers
(setq line-number-mode t)
;; column numbers
(setq column-number-mode t)

;; make ctrl-cg the goto line key binding
;;(global-set-key “\C-cg” ‘goto-line)
(global-set-key "\M-g" 'goto-line)

;; set the English dictionary for hunspell
(setenv "DICTIONARY" "english")

;; add .pyx files to python mode
(add-to-list 'auto-mode-alist '("\\.pyx\\'" . python-mode))

;;
;; Scheme setup

;; Always do syntax highlighting
;;(global-font-lock-mode 1)

;; Also highlight parens
;; (setq show-paren-delay 0
;;       show-paren-style 'parenthesis)
;; (show-paren-mode 1)

;; use Racket for Scheme
(setq scheme-program-name "\"/Applications/Racket v6.3/bin/racket\"")

;; makes Mac "home" and "end" go to beginning and end of line, rather than
;; beginning and end of file.
(define-key global-map [home] 'beginning-of-line)
(define-key global-map [end] 'end-of-line)

; (add-to-list 'load-path "~/.emacs.d/ess/lisp/")
; (load "ess-site")

;; Do whitespace cleanup when saving file
(add-hook 'before-save-hook 'whitespace-cleanup)

;;
;; Everything below here (modulo a few new packages) taken from:
;;   https://realpython.com/blog/python/emacs-the-best-python-editor/
;;
;; INSTALL PACKAGES
;; --------------------------------------

;; Get ready to install packages!!!
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)


(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(ample-theme
    better-defaults
    company
    elpy
    ess    ;; highlighting for stats modes (e.g. R, stata)
    flycheck
    flyspell
    go-mode
    irony
    json-reformat
    markdown-mode
    material-theme
    req-package
    yaml-mode))

;; Install any packages not yet installed
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(mode-enabled save idle-change))

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
;(global-linum-mode t) ;; enable line numbers globally
(elpy-enable) ;; use elpy, which does python autocomplete and autoindent (among

;;
;; C++ configurations
;;
(require 'req-package)

(req-package irony
             :config
             (progn
               ;; If irony server was never installed, install it.
               (unless (irony--find-server-executable) (call-interactively #'irony-install-server))

               (add-hook 'c++-mode-hook 'irony-mode)
               (add-hook 'c-mode-hook 'irony-mode)

               ;; Use compilation database first, clang_complete as fallback.
               (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
                                                               irony-cdb-clang-complete))

               (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
               ))

;; I use irony with company to get code completion.
(req-package company-irony
             :require company irony
             :config
             (progn
               (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))))

;; I use irony with flycheck to get real-time syntax checking.
(req-package flycheck-irony
             :require flycheck irony
             :config
             (progn
               (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))))

;; Eldoc shows argument list of the function you are currently writing in the echo area.
(req-package irony-eldoc
             :require eldoc irony
             :config
             (progn
                     (add-hook 'irony-mode-hook #'irony-eldoc)))



; also try cmake-ide?




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("fa11f855b5f606f84e50106a7360c72aac88fee5f6fb8084aa4329009b61c5a2" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
