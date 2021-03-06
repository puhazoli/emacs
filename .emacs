(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes nil)
 '(package-selected-packages
   (quote
    (ess auctex-latexmk pyenv-mode jedi multiple-cursors zenburn-theme realgud py-autopep8 magit flycheck use-package pandoc-mode markdown-mode helm-projectile fill-column-indicator exec-path-from-shell elpy ein docker company-jedi auctex gruvbox-theme ESS))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; add MELPA package system
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
;; check if all the desired packages are installed
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar my-packages
  '(auctex
    elpy
    flycheck
    magit
    py-autopep8
    pyvenv
    realgud
    gruvbox-theme
    docker-tramp
    multiple-cursors
    reftex
    exec-path-from-shell
    tramp
    ess
    ) 
  "A list of packages to ensure are installed at launch.")
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; enable elpy, activate default anaconda environment, use ipython, flycheck and py-autopep8
(setenv "IPY_TEST_SIMPLE_PROMPT" "1") ;; for fixing bug in elpy with ipython console
(elpy-enable)
(setq elpy-rpc-python-command "python3")
(setq python-shell-interpreter "python3")
(pyvenv-activate (expand-file-name "~/anaconda3/"))
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--max-line-length=80"))


;; use xetex instead of tex
(setq-default TeX-engine 'default)
;; disable welcome screen, menu and tool bar, enable line numbering,
;; disable git integration emacs, as we use magit and set up magit keybinding
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(menu-bar-mode -1) 
(tool-bar-mode -1)
(global-linum-mode t)
(setq vc-handled-backends nil)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; set up key binfing for elpy documentation
(global-set-key (kbd "C-x h") 'elpy-doc)
;; load custom theme
(load-theme 'gruvbox t)
;; load multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; load overwriting of selection
(delete-selection-mode 1)
(setq tramp-default-method "ssh")

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))
;; Turn on RefTeX in AUCTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; Activate nice interface between RefTeX and AUCTeX
(setq reftex-plug-into-AUCTeX t)

(setq reftex-default-bibliography '("~/Desktop/uvt/citations.bib"))
(setq ispell-program-name "/usr/local/bin/aspell")

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
      '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))

;; ESS
(require 'ess-site)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
