(setq user-emacs-directory "~/.emacs.d/")
;; line numbers
(setq line-number-mode t)
;; column numbers
(setq column-number-mode t)

;; make ctrl-cg the goto line key binding
;;(global-set-key “\C-cg” ‘goto-line)
(global-set-key "\M-g" 'goto-line)

(load-theme 'wombat)

;; set the English dictionary for hunspell
(setenv "DICTIONARY" "en_US")

;; makes Mac "home" and "end" go to beginning and end of line, rather than
;; beginning and end of file.
(define-key global-map [home] 'beginning-of-line)
(define-key global-map [end] 'end-of-line)

;; Do whitespace cleanup when saving file
(add-hook 'before-save-hook 'whitespace-cleanup)

;; everything below here is from:
;;    https://github.com/daviwil/emacs-from-scratch/blob/6d078217a41134cc667f969430d150c50d03f448/init.el
;; with some input from
;;    https://emacs-lsp.github.io/lsp-mode/tutorials/CPP-guide/
;;
;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; (setq project-vc-extra-root-markers '(".no-project"))
;; (setq lsp-pyright-use-project-root t)
;; (setq lsp-workspace-folders-use-projectile t)

;; (with-eval-after-load 'lsp-mode
;;   (setq lsp-enable-file-watchers t)
;;   (setq lsp-workspace-folders-use-projectile t))


(setq lsp-auto-guess-root nil)
;; (setq lsp-use-plists t) ;; not required but recommended


(setq lsp-enable-file-watchers t)
(setq lsp-pyright-use-project-root t)
(setq lsp-workspace-folders-use-projectile t)


(use-package lsp-mode
  :commands lsp
  :hook ((python-mode
	  c-mode
	  c++-mode
	  ) . lsp)
  :init
  (setq gc-cons-threshold (* 100 1024 1024)
	read-process-output-max (* 1024 1024)
	treemacs-space-between-root-nodes nil
	company-idle-delay 0.1
	company-minimum-prefix-length 1
	lsp-idle-delay 0.1
	lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
)

(setq lsp-auto-guess-root nil)   ;; does this fix starting in sandbox???

;; (use-package lsp-pyright
;;   :ensure t
;;   :custom (lsp-pyright-langserver-command "pyright") ;; or basedpyright
;;   :hook (python-mode . (lambda ()
;;			  (require 'lsp-pyright)
;;			  (lsp))))

;; (defun my/disable-lsp-watchers-in-sandbox ()
;;   (when (string-prefix-p (expand-file-name "/Users/kcrum/coding_space/sandbox")
;;			 (or (buffer-file-name) default-directory))
;;     (setq-local lsp-enable-file-watchers nil)))

;; (add-hook 'lsp-mode-hook #'my/disable-lsp-watchers-in-sandbox)

(use-package flycheck
					;:after lsp)
  :config (global-flycheck-mode))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

;; use yasnippet in all programming modes.
;; Without yasnippet, autocomplete loads argument placeholders
(use-package yasnippet
  :hook (prog-mode . yas-minor-mode-on))


;;  :init
;;  (add-hook 'prog-mode-hook 'yas-minor-mode))

(use-package lsp-ivy)

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
	 ("<tab>" . company-complete-selection))
	(:map lsp-mode-map
	 ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

;; (use-package company-box
;;   :hook (company-mode . company-box-mode))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map))
  ;; :init
  ;; ;; NOTE: Set this to the folder where you keep your Git repos!
  ;; (when (file-directory-p "/Users/kcrum/coding_space/sandbox")
  ;;   (setq projectile-project-search-path '("/Users/kcrum/coding_space/sandbox")))
  ;; (setq projectile-switch-project-action #'projectile-dired))

(defun my/project-register (project)
  "Ensure PROJECT is added to project-known-project-roots."
  (let ((root (project-root project)))
    (unless (member root (project-known-project-roots))
      (project-remember-project project))))

(add-hook 'project-find-functions
	  (lambda (dir)
	    (let ((pr (project-current nil dir)))
	      (when pr
		(my/project-register pr)
		nil))))

;; (use-package counsel-projectile
;;   :config (counsel-projectile-mode))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(counsel-projectile projectile company-box company lsp-ivy yasnippet lsp-treemacs lsp-ui lsp-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
