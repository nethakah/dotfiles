;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; (setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(setq doom-theme 'doom-one)
(setq org-log-repeat 'note)

;; Sublime Text 4 on macOS uses SF Mono; fall back to Menlo if it isn't installed
(setq doom-font (font-spec :family (if (find-font (font-spec :family "SF Mono"))
                                       "SF Mono"
                                     "Menlo")
                           :size 12
                           :weight 'regular))

;; new frames resolve fonts on their own, so force the same font on each one
(defun nh/apply-font-to-frame-h (frame)
  (when (display-graphic-p frame)
    (set-face-attribute 'default frame :font doom-font)
    (set-face-attribute 'fixed-pitch frame :font doom-font)))
(add-hook 'after-make-frame-functions #'nh/apply-font-to-frame-h)

;;; Sublime Text 4 (Mariana) look

(defconst nh/mariana
  '((bg        . "#303841")
    (bg-dark   . "#2a3139")
    (bg-darker . "#252b31")
    (line      . "#2c343d")
    (selection . "#4b5663")
    (fg        . "#d8dee9")
    (comment   . "#a6acb9")
    (gutter    . "#6d7a88")
    (blue      . "#6699cc")
    (teal      . "#5fb4b4")
    (green     . "#99c794")
    (orange    . "#f9ae58")
    (yellow    . "#fac863")
    (pink      . "#c594c5")
    (red       . "#ec5f67")
    (coral     . "#f97b58")))

(defun nh/color (name)
  (alist-get name nh/mariana))

;; extra faces for things Sublime colors but Emacs leaves plain
(defface nh-call-face     `((t :foreground ,(nh/color 'blue)))
  "Function and method calls.")
(defface nh-param-face    `((t :foreground ,(nh/color 'orange)))
  "Parameters in a function definition.")
(defface nh-operator-face `((t :foreground ,(nh/color 'coral)))
  "Operators.")
(defface nh-storage-face  `((t :foreground ,(nh/color 'pink) :slant italic))
  "def, class, struct, module, parameter and friends.")
(defface nh-modifier-face `((t :foreground ,(nh/color 'red)))
  "static, const, public, input, output and friends.")
(defface nh-class-face    `((t :foreground ,(nh/color 'yellow) :slant normal))
  "Class, struct and module names.")
(defface nh-prefix-face   `((t :foreground ,(nh/color 'red) :slant italic))
  "String prefixes like f, r, b.")

(custom-set-faces!
  ;; editor chrome
  `(default :background ,(nh/color 'bg) :foreground ,(nh/color 'fg))
  `(cursor :background ,(nh/color 'orange))
  `(region :background ,(nh/color 'selection) :extend t)
  `(hl-line :background ,(nh/color 'line))
  `(fringe :background ,(nh/color 'bg))
  `(line-number :foreground ,(nh/color 'gutter) :background ,(nh/color 'bg)
                :slant normal :weight normal)
  `(line-number-current-line :foreground ,(nh/color 'fg) :background ,(nh/color 'line)
                             :slant normal :weight normal)
  `(vertical-border :foreground ,(nh/color 'bg-darker) :background ,(nh/color 'bg-darker))
  `(mode-line :background ,(nh/color 'bg-darker) :foreground ,(nh/color 'fg) :box nil)
  `(mode-line-inactive :background ,(nh/color 'bg-dark) :foreground ,(nh/color 'gutter) :box nil)
  `(show-paren-match :foreground ,(nh/color 'orange) :background unspecified
                     :underline t :weight bold)
  `((solaire-default-face solaire-fringe-face solaire-line-number-face)
    :background ,(nh/color 'bg-dark))
  `(solaire-hl-line-face :background ,(nh/color 'line))

  ;; syntax
  `((font-lock-comment-face font-lock-comment-delimiter-face font-lock-doc-face)
    :foreground ,(nh/color 'comment) :slant normal)
  `(font-lock-string-face :foreground ,(nh/color 'green))
  `(font-lock-keyword-face :foreground ,(nh/color 'pink) :slant normal :weight normal)
  `((font-lock-builtin-face font-lock-type-face)
    :foreground ,(nh/color 'blue) :slant italic :weight normal)
  `(font-lock-function-name-face :foreground ,(nh/color 'teal) :slant normal :weight normal)
  `(font-lock-function-call-face :foreground ,(nh/color 'blue) :weight normal)
  `((font-lock-variable-name-face font-lock-variable-use-face
     font-lock-property-name-face font-lock-property-use-face)
    :foreground ,(nh/color 'fg) :weight normal)
  `(font-lock-constant-face :foreground ,(nh/color 'red) :slant italic :weight normal)
  `((font-lock-number-face highlight-numbers-number)
    :foreground ,(nh/color 'orange) :weight normal)
  `((font-lock-operator-face font-lock-negation-char-face) :foreground ,(nh/color 'coral))
  `(font-lock-preprocessor-face :foreground ,(nh/color 'pink) :slant normal :weight normal)
  `(font-lock-escape-face :foreground ,(nh/color 'orange))
  `((rainbow-delimiters-depth-1-face rainbow-delimiters-depth-2-face
     rainbow-delimiters-depth-3-face rainbow-delimiters-depth-4-face
     rainbow-delimiters-depth-5-face rainbow-delimiters-depth-6-face
     rainbow-delimiters-depth-7-face rainbow-delimiters-depth-8-face
     rainbow-delimiters-depth-9-face)
    :foreground ,(nh/color 'fg) :weight normal)
  `((verilog-font-lock-p1800-face verilog-font-lock-ams-face
     verilog-font-lock-grouping-keywords-face)
    :foreground ,(nh/color 'pink) :weight normal :slant normal :underline nil)

  ;; org source blocks
  `((org-block org-block-begin-line org-block-end-line)
    :background ,(nh/color 'bg-dark) :extend t))

;; helpers for the extra highlighting rules

(defun nh/--code-p (pos)
  "Non-nil when POS is outside comments and strings."
  (save-excursion
    (save-match-data
      (not (nth 8 (syntax-ppss pos))))))

(defun nh/--matcher (regexp)
  "Font-lock matcher for REGEXP that skips comments and strings."
  (lambda (limit)
    (let (found)
      (while (and (not found) (re-search-forward regexp limit t))
        (setq found (nh/--code-p (match-beginning 0))))
      found)))

(defun nh/--words (words)
  (concat "\\_<" (regexp-opt words t) "\\_>"))

(defun nh/--faces-at (pos)
  (let ((f (get-text-property pos 'face)))
    (if (listp f) f (list f))))

(defun nh/--in-def-arglist-p (pos)
  "Non-nil when POS sits inside the parameter list of a function definition."
  (save-excursion
    (save-match-data
      (let ((open (nth 1 (syntax-ppss pos))))
        (when (and open (eq (char-after open) ?\())
          (goto-char open)
          (skip-chars-backward " \t\n")
          (and (> (point) (point-min))
               (memq 'font-lock-function-name-face
                     (nh/--faces-at (1- (point))))))))))

(defun nh/--param-candidate-p (pos)
  (if (derived-mode-p 'python-mode)
      ;; a bare name right after ( or , (skips type hints and defaults)
      (and (null (get-text-property pos 'face))
           (save-excursion
             (goto-char pos)
             (skip-chars-backward " \t\n*")
             (memq (char-before) '(?\( ?,))))
    ;; cc-mode already marks parameter names as variables
    (memq 'font-lock-variable-name-face (nh/--faces-at pos))))

(defun nh/param-matcher (limit)
  (let (found)
    (while (and (not found)
                (re-search-forward "\\_<[[:alpha:]_][[:alnum:]_]*\\_>" limit t))
      (let ((beg (match-beginning 0)))
        (setq found (and (nh/--param-candidate-p beg)
                         (nh/--in-def-arglist-p beg)))))
    found))

(defun nh/py-fstring-matcher (limit)
  "Find {...} inside f-strings so the expression shows as plain code."
  (let (found)
    (while (and (not found) (re-search-forward "{[^{}\n]*}" limit t))
      (setq found
            (save-excursion
              (save-match-data
                (let ((start (nth 8 (syntax-ppss (match-beginning 0)))))
                  (and start
                       (nth 3 (syntax-ppss (match-beginning 0)))
                       (progn (goto-char start)
                              (skip-chars-backward "rRbB")
                              (memq (char-before) '(?f ?F)))))))))
    found))

;; Python
(font-lock-add-keywords
 'python-mode
 `((,(nh/--matcher (nh/--words '("def" "class" "lambda" "async")))
    1 'nh-storage-face t)
   (,(nh/--matcher "\\_<\\([rRbBuUfF]\\{1,2\\}\\)[\"']")
    1 'nh-prefix-face t)
   (,(nh/--matcher "^[ \t]*\\(@\\)\\(\\(?:[[:alnum:]_]+\\.\\)*\\)\\([[:alnum:]_]+\\)")
    (1 'font-lock-keyword-face t) (2 'default t) (3 'nh-call-face t))
   (nh/py-fstring-matcher 0 'default t)
   (nh/param-matcher 0 'nh-param-face t)
   ("\\_<\\([[:alpha:]_][[:alnum:]_]*\\)\\s-*(" 1 'nh-call-face)
   ("[-+*/%=<>!&|^~]+" 0 'nh-operator-face))
 'append)

;; class names in yellow like Sublime (Python uses the type face for them)
(defun nh/python-class-color-h ()
  (face-remap-add-relative 'font-lock-type-face
                           `(:foreground ,(nh/color 'yellow) :slant normal)))
(add-hook 'python-mode-hook #'nh/python-class-color-h)
(add-hook 'python-ts-mode-hook #'nh/python-class-color-h)

;; C / C++
(dolist (mode '(c-mode c++-mode))
  (font-lock-add-keywords
   mode
   `((,(nh/--matcher (nh/--words '("static" "constexpr" "consteval" "constinit" "const"
                                   "volatile" "inline" "extern" "virtual" "override"
                                   "final" "mutable" "explicit" "public" "private"
                                   "protected" "friend" "register" "thread_local"
                                   "noexcept")))
      1 'nh-modifier-face t)
     (,(nh/--matcher (nh/--words '("class" "struct" "union" "enum" "typedef" "template"
                                   "typename" "void" "bool" "auto" "char" "int" "short"
                                   "long" "float" "double" "signed" "unsigned" "wchar_t")))
      1 'nh-storage-face t)
     (,(nh/--matcher "\\_<\\(?:class\\|struct\\|union\\|enum\\(?:[ \t]+class\\)?\\)[ \t]+\\([[:alpha:]_][[:alnum:]_]*\\)")
      1 'nh-class-face t)
     ;; keep namespaces like std:: plain
     (,(nh/--matcher "\\_<\\([[:alpha:]_][[:alnum:]_]*\\)::")
      1 'default t)
     (nh/param-matcher 0 'nh-param-face t)
     ("\\_<\\([[:alpha:]_][[:alnum:]_]*\\)\\s-*[({]" 1 'nh-call-face)
     ("[-+*/%=<>!&|^~?]+" 0 'nh-operator-face))
   'append))

;; SystemVerilog (same logic: keywords pink, types blue italic, ports red,
;; module names yellow, calls/port connections blue, numbers orange)
(font-lock-add-keywords
 'verilog-mode
 `((,(nh/--matcher (nh/--words '("module" "endmodule" "macromodule" "interface"
                                 "endinterface" "package" "endpackage" "program"
                                 "endprogram" "class" "endclass" "function" "endfunction"
                                 "task" "endtask" "parameter" "localparam" "typedef"
                                 "enum" "struct" "union" "packed" "modport" "generate"
                                 "endgenerate" "automatic" "virtual" "extends")))
    1 'nh-storage-face t)
   (,(nh/--matcher (nh/--words '("input" "output" "inout" "ref" "const" "static"
                                 "var" "signed" "unsigned")))
    1 'nh-modifier-face t)
   (,(nh/--matcher (nh/--words '("logic" "wire" "reg" "bit" "byte" "shortint" "int"
                                 "longint" "integer" "time" "real" "shortreal"
                                 "realtime" "string" "void" "event" "genvar" "tri"
                                 "tri0" "tri1" "wand" "wor" "supply0" "supply1"
                                 "chandle")))
    1 'font-lock-type-face t)
   (,(nh/--matcher (nh/--words '("always" "always_ff" "always_comb" "always_latch"
                                 "initial" "final" "assign" "deassign" "force" "release"
                                 "if" "else" "begin" "end" "case" "casez" "casex"
                                 "endcase" "inside" "unique" "unique0" "priority"
                                 "default" "for" "foreach" "while" "do" "repeat"
                                 "forever" "return" "break" "continue" "posedge"
                                 "negedge" "edge" "or" "and" "not" "iff" "fork" "join"
                                 "join_any" "join_none" "wait" "disable" "import"
                                 "export" "new" "null" "this" "super" "assert" "assume"
                                 "cover" "property" "endproperty" "sequence"
                                 "endsequence" "covergroup" "endgroup" "constraint"
                                 "rand" "randc" "with")))
    1 'font-lock-keyword-face t)
   (,(nh/--matcher "\\_<\\(?:module\\|macromodule\\|interface\\|package\\|program\\|class\\)[ \t]+\\(?:\\(?:automatic\\|static\\)[ \t]+\\)?\\([[:alpha:]_][[:alnum:]_$]*\\)")
    1 'nh-class-face t)
   (,(nh/--matcher "\\(\\$[[:alpha:]_][[:alnum:]_$]*\\)")
    1 'font-lock-builtin-face t)
   (,(nh/--matcher "\\(`[[:alpha:]_][[:alnum:]_]*\\)")
    1 'font-lock-preprocessor-face t)
   (,(nh/--matcher "\\(\\(?:\\_<[0-9][0-9_]*\\)?'[sS]?[bBoOdDhH][ \t]*[0-9a-fA-FxXzZ?_]+\\|'[01xXzZ]\\_>\\|\\_<[0-9][0-9_]*\\(?:\\.[0-9_]+\\)?\\_>\\)")
    1 'font-lock-number-face t)
   ("\\_<\\([[:alpha:]_][[:alnum:]_$]*\\)\\s-*(" 1 'nh-call-face)
   ("[-+*/%=<>!&|^~?@#]+" 0 'nh-operator-face))
 'append)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(after! org
  (setq org-agenda-files
        (directory-files-recursively "~/org/" "\\.org\\'" nil nil t)))

(setq org-startup-folded 'content)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;
;; custom todo states for school
;;
(after! org
  ;; Define custom TODO states
  (setq org-todo-keywords
        '((sequence "TODO(t)" "EXAM(e)" "INTV(i)" "OA(o)" "|" "DONE(d)")))

  ;; Apply custom faces for each TODO state
  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "#88e788" :weight bold))
          ("EXAM" . (:foreground "#ee4b2b" :weight bold))
          ("INTV" . (:foreground "#c77dff" :weight bold))
          ("OA" . (:foreground "#9Acd32" :weight bold))
          ("DONE" . org-done))));;

(after! org
  ;; Default agenda setup: 30-day span, no future TODOs showing early
  (setq +org-agenda-default-span 30
        org-agenda-span 30
        org-agenda-start-on-weekday nil
        org-agenda-start-day "+0d"))

;;
;; Gray out done deadlines
;;
(after! org
  (defun my/gray-out-done-dates ()
    "Gray out DEADLINE:/SCHEDULED: keywords and dates on DONE tasks."
    (remove-overlays (point-min) (point-max) 'my-done-overlay t)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "^\\*+ \\(DONE\\|CANCELLED\\)" nil t)
        (let* ((element (org-element-at-point))
               (end (org-element-property :end element)))
          (save-excursion
            (while (and (< (point) end)
                        (re-search-forward "\\(SCHEDULED:\\|DEADLINE:\\)\\s-*\\(<[^>\n]+>\\)" end t))
              (let ((ov1 (make-overlay (match-beginning 1) (match-end 1))))
                (overlay-put ov1 'face '(:foreground "gray50"))
                (overlay-put ov1 'my-done-overlay t))
              (let ((ov2 (make-overlay (match-beginning 2) (match-end 2))))
                (overlay-put ov2 'face '(:foreground "gray50"))
                (overlay-put ov2 'my-done-overlay t))))))))

  (add-hook 'org-mode-hook
            (lambda ()
              (my/gray-out-done-dates)
              (add-hook 'after-save-hook #'my/gray-out-done-dates nil t)
              (add-hook 'org-after-todo-state-change-hook #'my/gray-out-done-dates nil t))))

;; open links in brave
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser")

;; agenda view shortcut
(map! :leader
      :desc "Org Agenda"
      "a" #'org-agenda-list)


;; frame shortcuts
(map! :leader
      :desc "New frame"
      "f n" #'make-frame-command)
(map! :leader
      :desc "Delete frame"
      "f q" #'delete-frame)
(map! :leader
      :desc "Minimize frame"
      "f m" #'iconify-frame)

;; toggle raw links
(map! :leader
      :desc "Toggle raw links"
      "o r" #'org-toggle-link-display)

;; lecture notes
(after! pdf-view
  (evil-collection-define-key 'normal 'pdf-view-mode-map
    "gi" #'org-noter-insert-precise-note
    "gI" #'org-noter-insert-note
    "q"  #'org-noter-kill-session))

(map! :after org
      :localleader
      :map org-mode-map
      :desc "Start noter session"
      "n" #'org-noter)

;; keep only 1 buffer (optimization)
(setq dired-kill-when-opening-new-dired-buffer t)

;;; TRAMP

(after! tramp
  ;; stop git from running over SSH on every buffer switch
  (setq vc-ignore-dir-regexp
        (format "\\(%s\\)\\|\\(%s\\)"
                vc-ignore-dir-regexp
                tramp-file-name-regexp))
  ;; let your ssh config's connection reuse actually apply
  (setq tramp-use-ssh-controlmaster-options nil))

;;; VSCode-style editing in every file

(defvar nh/indent-width 4)

;; no reindenting as you type, no smart indent on o/O
(electric-indent-mode -1)
(setq-default evil-auto-indent nil
              indent-tabs-mode nil)

;; stop Doom from guessing indent style from file contents
(remove-hook 'change-major-mode-after-body-hook #'doom-detect-indentation-h)
(remove-hook 'read-only-mode-hook #'doom-detect-indentation-h)

;; Makefiles and Go need real tabs
(defun nh/tabs-allowed-p ()
  (derived-mode-p 'makefile-mode 'go-mode))

;; runs after every mode's own setup, so modes can't turn tabs back on
(defun nh/force-spaces-h ()
  (unless (nh/tabs-allowed-p)
    (setq-local indent-tabs-mode nil)
    ;; Org requires tab-width 8, so leave it alone there
    (unless (derived-mode-p 'org-mode)
      (setq-local tab-width nh/indent-width)))
  (setq-local evil-shift-width nh/indent-width))
(add-hook 'after-change-major-mode-hook #'nh/force-spaces-h 90)

;; catch tabs that arrive by paste
(defun nh/untabify-buffer ()
  (unless (nh/tabs-allowed-p)
    (untabify (point-min) (point-max))))
(add-hook 'before-save-hook #'nh/untabify-buffer)

;; 1. TAB inserts spaces to the next 2-column stop
(defun nh/tab ()
  (interactive)
  (cond
   ((and (derived-mode-p 'org-mode) (org-at-table-p))
    (org-table-next-field))
   ((nh/tabs-allowed-p)
    (insert "\t"))
   (t
    (insert (make-string (- nh/indent-width
                            (% (current-column) nh/indent-width))
                         ?\s)))))

;; 2. RET keeps the current line's indentation
(defun nh/newline ()
  (interactive)
  (let ((indent (buffer-substring-no-properties
                 (line-beginning-position)
                 (save-excursion (back-to-indentation) (point)))))
    (insert "\n")
    (delete-horizontal-space)
    (insert indent)))

;; 3. Backspace inside leading spaces deletes back to the previous 2-column stop
(defun nh/backspace ()
  (interactive)
  (if (and (not (nh/tabs-allowed-p))
           (> (current-column) 0)
           (save-excursion (skip-chars-backward " ") (bolp)))
      (let ((target (* nh/indent-width
                       (/ (1- (current-column)) nh/indent-width))))
        (delete-region (save-excursion (move-to-column target) (point))
                       (point)))
    (call-interactively
     (if (derived-mode-p 'org-mode)
         #'org-delete-backward-char
       #'delete-backward-char))))

;; A mode whose insert-state keys override every other mode's bindings
(defvar nh-editing-mode-map (make-sparse-keymap))

(define-minor-mode nh-editing-mode
  "VSCode-style TAB, RET and backspace in insert state."
  :keymap nh-editing-mode-map
  (evil-normalize-keymaps))

;; on everywhere except shells/terminals, where TAB and RET belong to the shell
(defun nh-editing-mode--maybe ()
  (unless (or (minibufferp)
              (derived-mode-p 'comint-mode 'term-mode 'vterm-mode 'eshell-mode))
    (nh-editing-mode 1)))

(define-globalized-minor-mode nh-global-editing-mode
  nh-editing-mode nh-editing-mode--maybe)

(after! evil
  (evil-make-intercept-map nh-editing-mode-map 'insert t)
  (evil-define-key* 'insert nh-editing-mode-map
    (kbd "TAB") #'nh/tab
    [tab]       #'nh/tab
    (kbd "RET") #'nh/newline
    [return]    #'nh/newline
    (kbd "DEL") #'nh/backspace
    [backspace] #'nh/backspace)
  (nh-global-editing-mode 1))

;;; SystemVerilog

(after! org
  (add-to-list 'org-src-lang-modes '("systemverilog" . verilog)))

(after! verilog-mode
  (setq verilog-auto-lineup nil
        verilog-auto-indent-on-newline nil
        verilog-auto-newline nil
        verilog-tab-always-indent nil
        verilog-indent-lists nil
        verilog-auto-endcomments nil
        verilog-indent-level 0
        verilog-indent-level-module 0
        verilog-indent-level-declaration 0
        verilog-indent-level-behavioral 0
        verilog-indent-level-directive 0
        verilog-case-indent 0
        verilog-cexp-indent 0)

  (add-hook 'verilog-mode-hook
            (lambda ()
              (setq-local indent-line-function #'ignore)
              (electric-indent-local-mode -1))))

;; stop verilog-mode's electric keys from reformatting
(map! :after verilog-mode
      :map verilog-mode-map
      ";" #'self-insert-command
      ":" #'self-insert-command
      "," #'self-insert-command
      ")" #'self-insert-command
      "`" #'self-insert-command
      "=" #'self-insert-command)

;; Open external files in new frames (macOS Emacs Mac Port)
(defun nh/open-external-in-new-frame (orig-fn &rest args)
  (let ((dnd-open-file-other-window t)
        (pop-up-frames t))
    (apply orig-fn args)))

(advice-add 'mac-ae-open-documents :around
            #'nh/open-external-in-new-frame)
