;;; Commentary:
;;----------
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
;; package
(require 'package)
(setq package-user-dir "~/.emacs.d/lisp/elpa/")
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
;; auto install
(require 'cl)
(defvar installing-package-list
  '(
    ;; package list
    init-loader
    multi-term
    evil
    evil-leader
    evil-numbers
    evil-nerd-commenter
    rainbow-delimiters
    rainbow-mode
    company
    company-quickhelp
    flycheck
    flycheck-pos-tip
    fill-column-indicator
    ))
(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))

;;----------
;; load-path で ~/.emacs.d とか書かなくてよくなる
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;----------
;; el-get
(add-to-list 'load-path (locate-user-emacs-file "lisp/el-get"))
;; el-getでダウンロードしたパッケージは ~/.emacs.d/lisp に入るようにする
(setq el-get-dir (locate-user-emacs-file "lisp"))
(require 'el-get)

;;----------
;; bundle
(el-get-bundle auto-complete)
(el-get-bundle color-theme)
(el-get-bundle anything)
;;(el-get-bundle anaconda-mode)
;;(el-get-bundle eldoc-extension)
;(el-get-bundle multi-term)

;;----------
;;anaconda-mode

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)
;; use IPython
(setq python-shell-interpreter "ipython")

(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-anaconda))

(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0)

(company-quickhelp-mode 1)

;;; enable flycheck
;;; flycheck
(require 'flycheck)
(require 'pos-tip)
(add-hook 'after-init-hook #'global-flycheck-mode)
;;(eval-after-load 'flycheck
;;  '(custom-set-variables
;;    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
;;; To disable flycheck, add emacs-lisp-checkdo
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; enable fill-column-indicator for 80char line indication
;;(require 'fill-column-indicator)
;;(add-hook 'prog-mode-hook 'fci-mode)
;;(setq fci-rule-column 120)

;;(defvar-local company-fci-mode-on-p nil)
;;
;;(defun company-turn-off-fci (&rest ignore)
;;  (when (boundp 'fci-mode)
;;    (setq company-fci-mode-on-p fci-mode)
;;    (when fci-mode (fci-mode -1))))
;;(defun company-maybe-turn-on-fci (&rest ignore)
;;  (when company-fci-mode-on-p (fci-mode 1)))
;;
;;(add-hook 'company-completion-started-hook 'company-turn-off-fci)
;;(add-hook 'company-completion-finished-hook 'company-maybe-turn-on-fci)
;;(add-hook 'company-completion-cancelled-hook 'company-maybe-turn-on-fci)

;;----------
;;multi-term
(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))
 (when (and (file-exists-p dir) (not (member dir exec-path)))
   (setenv "PATH" (concat dir ":" (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path))))

;;(setq load-path(cons "~/.emacs.d/" load-path))
(setq multi-term-program "/bin/bash")
(require 'multi-term)

;;
(require 'linum)
(global-linum-mode)
(column-number-mode t)
