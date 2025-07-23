(setq custom-file (concat (file-name-directory (or load-file-name (buffer-file-name))) "./init.custom.el"))
(load custom-file)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t
      visible-bell nil)
(setq warning-minimum-level :error)
(add-to-list 'default-frame-alist `(font . "Hasklug Nerd Font:style=Regular"))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode)
(setq frame-resize-pixelwise t)
(dotimes (n 3)
  (toggle-frame-maximized))

(add-to-list 'load-path "~/.config/emacs/local")
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(ido-mode 1)
(ido-everywhere 1)

(package-initialize)
(load-file "~/.config/emacs/local/rc.el")

(rc/require-theme 'gruber-darker)
(rc/require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)

(defun rc/duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(global-set-key (kbd "C-,") 'rc/duplicate-line)

(setq split-width-threshold nil)

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

(setq org-hide-emphasis-markers t)
(font-lock-add-keywords 'org-mode
                        '(("^ +\\([-*]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(rc/require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(let ((path ("/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin")))
  (setenv "PATH" path)
  (setq exec-path path))

(setq make-backup-files nil)

(rc/require 'magit)
