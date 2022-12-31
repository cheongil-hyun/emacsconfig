(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

;; ----------------------------------------------------------------------------
;; Compilation output buffer auto scroll
;; ----------------------------------------------------------------------------
(setq compilation-scroll-output t)

;; ----------------------------------------------------------------------------
;; emacs auto reloading when file was changed from external program
;; ----------------------------------------------------------------------------
(global-auto-revert-mode 1)

;; ----------------------------------------------------------------------------
;; Yes and No
;; ----------------------------------------------------------------------------
(defalias 'yes-or-no-p 'y-or-n-p)

;; ----------------------------------------------------------------------------
;; disable the backup
;; ----------------------------------------------------------------------------
(setq backup-inhibited t)

;; ----------------------------------------------------------------------------
;; disable auto save files
;; ----------------------------------------------------------------------------
(setq auto-save-default nil)

;; (set-face-attribute 'default nil :font "Fira Code Retina" :height 280)

(load-theme 'wombat)

;; set "gnu" style indenting for C
(setq c-default-style "linux"
      c-basic-offset 4)

;; Make ESC quit prompts
;; (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

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

(column-number-mode) 			; Display Column number in bottom 
(global-display-line-numbers-mode t)	; Display line number in left side (similar to vim)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; (use-package command-log-mode)

(use-package swiper)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ;; ("C-j" . ivy-next-line)
         ;; ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ;; ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ;; ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))	;; Don't start searches with ^

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))
;;------------------------------------------------------------------------
;; org mode Settings
;;------------------------------------------------------------------------
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
;; setting org files for org-agenda
(setq org-agenda-files (list "~/org/Task.org" "~/org/Schedule.org" "~/org/notes.org" "~/org/project.org"))

(setq org-directory "~/org/")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/Task.org" "Tasks")
		 "* TODO %?\n  %i\n  %a")
        ("i" "Ideas" entry (file+datetree "~/org/notes.org")
		 "* %?\nIdeas %U\n  %i\n  %a")))

;; ----------------------------------------------------------------------------
;; org mode auto indent mode enable
;; ----------------------------------------------------------------------------
(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode t)
	    (auto-fill-mode 1)
	    )
          t)

;;------------------------------------------------------------------------
;; shell-pop
;;------------------------------------------------------------------------
(load-file "~/.emacs.d/packages/shell-pop.el")
(require 'shell-pop)
(shell-pop-set-internal-mode "eshell")
(shell-pop-set-internal-mode-shell "/bin/bash")
(shell-pop-set-window-height 60) ; the number for the percentage of the selected window.
(global-set-key [f10] 'shell-pop)

;; ----------------------------------------------------------------------------
;;  korean font setting - cygwin emacs does not support
;; ----------------------------------------------------------------------------
;; need to install Nanum gothic function first as below
;; sudo apt-get install -y fontconfig
;; curl -o nanumfont.zip http://cdn.naver.com/naver/NanumFont/fontfiles/NanumFont_TTF_ALL.zip 
;; sudo unzip -d /usr/share/fonts/nanum nanumfont.zip
;; ----------------------------------------------------------------------------
(set-language-environment "Korean")
(prefer-coding-system 'utf-8)
(setq default-input-method "korean-hangul")
(global-set-key (kbd "<S-SPC>") 'toggle-input-method)
(set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(helpful counsel ivy-rich which-key use-package swiper doom-modeline)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
