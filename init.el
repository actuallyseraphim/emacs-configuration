(setq custom-file (file-name-concat user-emacs-directory "custom.init.el"))
(add-to-list 'load-path (file-name-concat user-emacs-directory "local"))
(load custom-file t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(add-hook 'prog-mode-hook (lambda() (display-line-numbers-mode 1)))
(add-hook 'text-mode-hook (lambda() (display-line-numbers-mode 1)))

(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

(setq display-line-numbers-type 'relative)
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(setq warning-minimum-level :error)
(setq make-backup-files nil)
(setq-default indent-tabs-mode nil)

(c-set-offset 'arglist-intro '+)
(c-set-offset 'arglist-cont-nonempty '+)
(c-set-offset 'arglist-close '0)

(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker))

(add-to-list 'default-frame-alist '(font . "Fira Code-16"))
;; https://github.com/mickeynp/ligature.el/wiki
(use-package ligature
  :ensure t
  :load-path "path-to-ligature-repo"
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia and Fira Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode
                        '(;; == === ==== => =| =>>=>=|=>==>> ==< =/=//=// =~
                          ;; =:= =!=
                          ("=" (rx (+ (or ">" "<" "|" "/" "~" ":" "!" "="))))
                          ;; ;; ;;;
                          (";" (rx (+ ";")))
                          ;; && &&&
                          ("&" (rx (+ "&")))
                          ;; !! !!! !. !: !!. != !== !~
                          ("!" (rx (+ (or "=" "!" "\." ":" "~"))))
                          ;; ?? ??? ?:  ?=  ?.
                          ("?" (rx (or ":" "=" "\." (+ "?"))))
                          ;; %% %%%
                          ("%" (rx (+ "%")))
                          ;; |> ||> |||> ||||> |] |} || ||| |-> ||-||
                          ;; |->>-||-<<-| |- |== ||=||
                          ;; |==>>==<<==<=>==//==/=!==:===>
                          ("|" (rx (+ (or ">" "<" "|" "/" ":" "!" "}" "\]"
                                          "-" "=" ))))
                          ;; \\ \\\ \/
                          ("\\" (rx (or "/" (+ "\\"))))
                          ;; ++ +++ ++++ +>
                          ("+" (rx (or ">" (+ "+"))))
                          ;; :: ::: :::: :> :< := :// ::=
                          (":" (rx (or ">" "<" "=" "//" ":=" (+ ":"))))
                          ;; // /// //// /\ /* /> /===:===!=//===>>==>==/
                          ("/" (rx (+ (or ">"  "<" "|" "/" "\\" "\*" ":" "!"
                                          "="))))
                          ;; .. ... .... .= .- .? ..= ..<
                          ("\." (rx (or "=" "-" "\?" "\.=" "\.<" (+ "\."))))
                          ;; -- --- ---- -~ -> ->> -| -|->-->>->--<<-|
                          ("-" (rx (+ (or ">" "<" "|" "~" "-"))))
                          ;; *> */ *)  ** *** ****
                          ("*" (rx (or ">" "/" ")" (+ "*"))))
                          ;; www wwww
                          ("w" (rx (+ "w")))
                          ;; <> <!-- <|> <: <~ <~> <~~ <+ <* <$ </  <+> <*>
                          ;; <$> </> <|  <||  <||| <|||| <- <-| <-<<-|-> <->>
                          ;; <<-> <= <=> <<==<<==>=|=>==/==//=!==:=>
                          ;; << <<< <<<<
                          ("<" (rx (+ (or "\+" "\*" "\$" "<" ">" ":" "~"  "!"
                                          "-"  "/" "|" "="))))
                          ;; >: >- >>- >--|-> >>-|-> >= >== >>== >=|=:=>>
                          ;; >> >>> >>>>
                          (">" (rx (+ (or ">" "<" "|" "/" ":" "=" "-"))))
                          ;; #: #= #! #( #? #[ #{ #_ #_( ## ### #####
                          ("#" (rx (or ":" "=" "!" "(" "\?" "\[" "{" "_(" "_"
                                       (+ "#"))))
                          ;; ~~ ~~~ ~=  ~-  ~@ ~> ~~>
                          ("~" (rx (or ">" "=" "-" "@" "~>" (+ "~"))))
                          ;; __ ___ ____ _|_ __|____|_
                          ("_" (rx (+ (or "_" "|"))))
                          ;; Fira code: 0xFF 0x12
                          ("0" (rx (and "x" (+ (in "A-F" "a-f" "0-9")))))
                          ;; Fira code:
                          "Fl"  "Tl"  "fi"  "fj"  "fl"  "ft"
                          ;; The few not covered by the regexps.
                          "{|"  "[|"  "]#"  "(*"  "}#"  "$>"  "^="))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(add-to-list 'auto-mode-alist '("\\.[b]\\'" . simpc-mode))

(require 'fasm-mode)
(add-to-list 'auto-mode-alist '("\\.asm\\'" . fasm-mode))

(add-to-list 'auto-mode-alist '("\\.fsh\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.vsh\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.gsh\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.csh\\'" . glsl-mode))


(require 'simpc3-mode)

(ido-mode 1)
(ido-everywhere 1)
(use-package smex
  :ensure t
  :bind (("M-x" . 'smex)
	 ("C-c C-c M-x" . 'execute-extended-command)))

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . 'mc/edit-lines)
         ("C->" . 'mc/mark-next-like-this)
         ("C-<" . 'mc/mark-previous-like-this)
         ("C-c C-<" . 'mc/mark-all-like-this)
         ("C-\"" . 'mc/skip-to-next-like-this)
         ("C-:" . 'mc/skip-to-previous-like-this)))

;; https://github.com/rexim/dotfiles
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

(add-hook 'after-init-hook 'global-company-mode)

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package magit
  :ensure t)

(use-package haskell-mode
  :ensure t)


(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((java-mode . lsp)
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package helm-lsp
  :ensure t
  :commands helm-lsp-workspace-symbol)

(use-package dap-mode
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(require 'project)
(add-to-list 'project-vc-extra-root-markers "build.gradle")
(add-to-list 'project-vc-extra-root-markers "build.gradle.kts")
(add-to-list 'project-vc-extra-root-markers "settings.gradle")
(add-to-list 'project-vc-extra-root-markers "settings.gradle.kts")

(use-package websocket
  :ensure t)

(use-package typst-preview
  :ensure t
  :init
  (setq typst-preview-autostart t)
  (setq typst-preview-open-browser-automatically t)

  :custom
  (typst-preview-browser "xwidget")
  (typst-preview-executable "tinymist")
  (typst-preview-partial-rendering t)
  
  :config
  (define-key typst-preview-mode-map (kbd "C-c C-j") 'typst-preview-send-position))

(defun typst-preview-xwidget (url)
  (split-window-right)
  (other-window 1)
  (xwidget-webkit-browse-url url))

(with-eval-after-load 'typst-preview
  (advice-add
   'typst-preview--connect-browser
   :override
   (lambda (browser hostname)
     (pcase browser
       ("xwidget"
        (typst-preview-xwidget (concat "http://" hostname)))
       ("default"
        (browse-url (concat "http://" hostname)))
       ("eaf-browser"
        (eaf-open-browser-other-window (concat "http://" hostname)))))))

(defvar denote-typst-front-matter
  "// title:      %s
// date:       %s
// tags:       %s
// identifier: %s
"
  "Front matter for new Typst notes created by Denote.")

(defvar denote-typst-link-format "// %2$s <denote:%1$s>"
  "Format of a Denote link inside a Typst file.")

(defvar denote-typst-link-in-context-regexp
  "//.*?<denote:\\([0-9]\\{8\\}T[0-9]\\{6\\}\\)>"
  "Regexp matching `my-denote-typst-link-format' in context.")

(use-package denote
  :ensure t
  :hook (dired-mode . denote-dired-mode)
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n d" . denote-dired)
   ("C-c n g" . denote-grep))
  :config
  (setq denote-directory (expand-file-name "~/notes/"))
  (denote-rename-buffer-mode 1)  
  (add-to-list 'denote-file-types
               `(typst
                 :extension ".typ"
                 :date-function denote-date-iso-8601
                 :front-matter denote-typst-front-matter
                 :title-key-regexp "^// title\\s-*:"
                 :title-value-function identity
                 :title-value-reverse-function denote-trim-whitespace
                 :keywords-key-regexp "^// tags\\s-*:"
                 :keywords-value-function denote-format-keywords-for-text-front-matter
                 :keywords-value-reverse-function denote-extract-keywords-from-front-matter
                 :link denote-typst-link-format
                 :link-in-context-regexp denote-typst-link-in-context-regexp))
  (setq denote-file-type 'typst))
