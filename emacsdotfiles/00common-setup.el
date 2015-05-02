; set the default font size
(set-face-attribute 'default nil :height 110)

;; Set the starting position and width and height of Emacs Window
(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(height . 55))
(add-to-list 'default-frame-alist '(width . 230))

;; (require 'maxframe)
;; (add-hook 'window-setup-hook 'maximize-frame t)

(setq inhibit-startup-message t)
(tool-bar-mode -1)

(require 'moe-theme)
(moe-dark)

;; Determin where we are
(defvar on_darwin
  (string-match "darwin" (prin1-to-string system-type)))

(defvar on_gnu_linux
  (string-match "gnu/linux" (prin1-to-string system-type)))

(defvar on_X
  (string-match "x" (prin1-to-string window-system)))

(defvar on_Terminal
  (string-match "nil" (prin1-to-string window-system)))

(require 'color-theme-wombat)
(color-theme-wombat)

;; Delete Selection
(delete-selection-mode 1)
(setq shift-select-mode nil)

;; Prefer utf-8 encoding
(prefer-coding-system 'utf-8)

;; Display continuous lines
(setq-default truncate-lines nil)
;; trucate even even when screen is split into multiple windows
(setq-default truncate-partial-width-windows nil)

;; Do not use tabs for indentation
(setq-default indent-tabs-mode nil)
;; Define tab width
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

;; Highlight incremental search
(setq search-highlight t)
(transient-mark-mode t)

(menu-bar-mode t)

;; Show line-number in the mode line
(line-number-mode 1)
;; Show column-number in the mode line
(column-number-mode 1)


;;25functions.el

(defun recentf-open-files-compl ()
  (interactive)
  (let* ((all-files recentf-list)
	 (tocpl (mapcar (function
			 (lambda (x) (cons (file-name-nondirectory x) x))) all-files))
	 (prompt (append '("File name: ") tocpl))
	 (fname (completing-read (car prompt) (cdr prompt) nil nil)))
    ;; (find-file (cdr (assoc-ignore-representation fname tocpl)))))
    (find-file (cdr (assoc-string fname tocpl)))))
(global-set-key (kbd "C-x C-r") 'recentf-open-files-compl)
(global-set-key (kbd "C-c C-r") 'recentf-open-files-compl)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1))))) 
(global-set-key "(" 'match-paren)

(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
(define-key global-map (kbd "C-c f") 'wy-go-to-char) ;; go-to-char

(defun ai-insert-date ()
  (interactive)
  (insert (format-time-string "%Y/%m/%d %H:%M:%S" (current-time))))
(global-set-key (kbd "C-c d") 'ai-insert-date)

(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register.
Use ska-jump-to-register to jump back to the stored
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
    (jump-to-register 8)
    (set-register 8 tmp)))

;; 25modes.el
;; go to last edit location (super useful)
(require 'goto-last-change)
(global-set-key (kbd "C-c C-q") 'goto-last-change)

;; setup for ido
(require 'ido)
(ido-mode t)
(setq ido-everywhere t)

;; Display ido results vertically, rather than horizontally
;; (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;; (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
;; (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
;; (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
;;   (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
;;   (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
;; (add-hook 'ido-setup-hook 'ido-define-keys)

;; list all used buffers for each re-trieve
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups
;; (setq make-backup-files nil) ; stop creating those backup~ files
;; (setq auto-save-default nil) ; stop creating those #autosave# files

;; line number
(setq linum-format "%4d")
(cond (on_Terminal
       (progn
         (setq linum-format "%4d| "))))

(global-linum-mode 1)
(require 'linum-off)

(require 'whitespace)
(setq-default whitespace-line-column 100) ;; limit line length
(setq-default whitespace-style '(face lines-tail tailing))

(setq-default show-trailing-whitespace t)

(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'before-save-hook 'whitespace-cleanup)

(require 'ws-trim)

(global-ws-trim-mode t)
(set-default 'ws-trim-level 1)
(setq ws-trim-global-modes '(guess (not message-mode eshell-mode)))
(add-hook 'ws-trim-method-hook 'joc-no-tabs-in-java-hook)

;; Projectile
(require 'grizzl)
(projectile-global-mode)
(setq projectile-enable-caching t)
;; (setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)
;; Press Command-p for fuzzy find in project
(global-set-key (kbd "C-c C-p") 'projectile-find-file)
;; Press Command-b for fuzzy switch buffer
(global-set-key (kbd "C-c C-b") 'projectile-switch-to-buffer)
;; Open the top-level directory of the project in a dired buffer
(setq projectile-switch-project-action 'projectile-dired)
;; Press Command-a for Ag search
(global-set-key (kbd "C-c C-a") 'projectile-ag)

;; highlight-indentation
(require 'highlight-indentation)
(add-hook 'enh-ruby-mode-hook
    (lambda () (highlight-indentation-current-column-mode)))

(add-hook 'coffee-mode-hook
    (lambda () (highlight-indentation-current-column-mode)))

(setq-default indent-tabs-mode nil)

(require 'smart-quotes)
(add-hook 'text-mode-hook 'turn-on-smart-quotes)
(quote (("british" "[[:alpha:]]" "[^[:alpha:]]" "['’]" t ("-d" "en_GB") nil utf-8)))

;; show and hide mode enable for javascript
(add-hook 'js-mode-hook
     (lambda ()
        ;; Scan the file for nested code blocks
        (imenu-add-menubar-index)
        ;; Activate the folding mode
        (hs-minor-mode t)))

;; Show-hide
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(add-hook 'ruby-mode-hook       'hs-minor-mode)

(global-set-key (kbd "C-c ,") 'hs-show-blocak)
(global-set-key (kbd "C-c .") 'hs-show-all)
(global-set-key (kbd "C-c ,") 'hs-hide-block)
(global-set-key (kbd "C-c .") 'hs-hide-all)
