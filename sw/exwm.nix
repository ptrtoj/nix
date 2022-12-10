{ config, pkgs, ... }:
{
  services.emacs.enable = true;
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.all-the-icons
      epkgs.company
      epkgs.dashboard
      epkgs.doom-modeline
      epkgs.exwm
      epkgs.flycheck
      epkgs.helm
      epkgs.magit
      epkgs.neotree
      epkgs.nix-mode
      epkgs.nord-theme
      epkgs.org
      epkgs.org-bullets
      epkgs.page-break-lines
      epkgs.projectile
      epkgs.rainbow-delimiters
      epkgs.smartparens
      epkgs.which-key
    ];
    extraConfig = ''

(setq user-full-name "WooHyung Jeon"
      user-mail-address "a@j.day")

(setq gc-cons-threshold (* 50 1000 1000))
(setq large-file-warning-threshold (* 10 1000 1000))

(defun jeon/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
	   (format "%.2f seconds"
		   (float-time
		    (time-subtract after-init-time before-init-time)))
	   gcs-done))

(add-hook 'emacs-startup-hook #'jeon/display-startup-time)

(windmove-default-keybindings)

(global-set-key (kbd "C-c h") 'windmove-left)
(global-set-key (kbd "C-c l") 'windmove-right)
(global-set-key (kbd "C-c k") 'windmove-up)
(global-set-key (kbd "C-c j") 'windmove-down)

(global-set-key (kbd "C-c H") 'shrink-window-horizontally)
(global-set-key (kbd "C-c L") 'enlarge-window-horizontally)
(global-set-key (kbd "C-c J") 'shrink-window)
(global-set-key (kbd "C-c K") 'enlarge-window)

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
;; was bind to 'open read only mode'
(save-place-mode 1)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(defun jeon/ansi-term ()
  (interactive)
  (ansi-term (getenv "SHELL")))
(global-set-key (kbd "s-<return>") #'jeon/ansi-term)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq inhibit-startup-message t)
(setq visible-bell t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(menu-bar-mode -1)          ; Disable the menu bar
(set-fringe-mode 10)        ; Give some breathing room

(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

(set-face-attribute 'default nil :font "BerkeleyMono NFM" :height 90)
(set-face-attribute 'fixed-pitch nil :font "BerkeleyMono NFM" :height 90)
(set-face-attribute 'variable-pitch nil :font "BerkeleyMono NFM" :height 90)

;; Make frame transparency overridable
(defvar jeon/frame-transparency '(90 . 80))

;; Set frame transparency
;; Also works with Gnome/Xorg
(set-frame-parameter (selected-frame) 'alpha jeon/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,jeon/frame-transparency))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(display-battery-mode 1)
(display-time-mode 1)

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers 'relative)
(global-hl-line-mode t)

;; Disable line numbers for some modes
(dolist (mode '(term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(doom-modeline-mode 1)

(load-theme 'nord t)

(add-hook 'after-init-hook 'global-company-mode)

(setq dashboard-items '((recents . 15)))
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-startup-banner 3)
(dashboard-setup-startup-hook)

(global-flycheck-mode)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)
(eval-after-load 'helm
  (lambda ()
    (set-face-attribute 'helm-source-header nil
			:height 90)))

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(global-set-key [f5] 'neotree-toggle)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(add-hook 'org-mode-hook #'rainbow-delimiters-mode)

(which-key-mode)
(setq which-key-idle-delay 0.1)

(setq exwm-input-global-keys
      `(([?\s-r] . exwm-reset)
	([?\s-w] . exwm-workspace-switch)
	(,(kbd "s-&") .
	 (lambda (command)
	   (interactive (list (read-shell-command "$ ")))
	   (start-process-shell-command command nil command)))
	,@(mapcar (lambda (i)
		    `(,(kbd (format "s-%d" i)) .
		      (lambda ()
			(interactive)
			(exwm-workspace-switch-create ,i))))
		  (number-sequence 0 9))))

(defun exwm-rename-buffer ()
  (interactive)
  (exwm-workspace-rename-buffer
   (concat exwm-class-name ":"
	   (if (<= (length exwm-title) 50) exwm-title
	     (concat (substring exwm-title 0 49) "...")))))
;; Add these hooks in a suitable place (e.g., as done in exwm-config-default)
(add-hook 'exwm-update-class-hook 'exwm-rename-buffer)
(add-hook 'exwm-update-title-hook 'exwm-rename-buffer)

(setq exwm-workspace-number 9)

(require 'exwm-randr)
(defun jeon/dmon ()
  (interactive)
  (setq exwm-randr-workspace-monitor-plist '(0 "HDMI-A-0" 1 "eDP"))
  (start-process-shell-command
   "xradr" nil "xrandr --output eDP --primary --mode 1920x1080 --pos 1920x1080 --rotate normal --output HDMI-A-0 --mode 1920x1080 --pos 1920x0 --rotate normal --output DisplayPort-0 --off --output DisplayPort-1 --off"))
; My laptop keyboard has F7 as monitor selection, so it's became F7 :)
(global-set-key [f7] #'jeon/dmon)
(exwm-randr-enable)

(exwm-enable)

(add-hook 'before-save-hook 'whitespace-cleanup)

'';
  };
}
