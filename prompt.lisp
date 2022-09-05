#|
 This file is a part of trial
 (c) 2018 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.trial)

(defvar *prompt-string-table* (make-hash-table :test 'eq))

(defmacro define-glyph-table (name &body entries)
  (destructuring-bind (name &key inherit) (enlist name)
    `(setf (gethash ',name *prompt-string-table*)
           (let ((table (make-hash-table :test 'eq)))
             ,@(when inherit
                 `((loop for name being the hash-keys of (gethash ',inherit *prompt-string-table*) using (hash-value char)
                          do (setf (gethash name table) char))))
             ,@(loop for (name char) in entries
                     collect `(setf (gethash ',name table)
                                    ,(string (etypecase char
                                               (integer (code-char char))
                                               (string char)
                                               (character char)))))
             table))))

(define-glyph-table :devices
  (:GAMEPAD       #x243C)
  (:KEYBOARD      #x243D)
  (:MOUSE         #x243E)
  (:KEYBOARD-MOUSE #x243F))

(define-glyph-table :gamepad
  (:DEVICE        #x243C)
  (:DPAD-L        #x219E)
  (:DPAD-U        #x219F)
  (:DPAD-R        #x21A0)
  (:DPAD-D        #x21A1)
  (:X             #x21A4)
  (:Y             #x21A5)
  (:B             #x21A6)
  (:A             #x21A7)
  (:L1            #x21B0)
  (:R1            #x21B1)
  (:L2            #x21B2)
  (:R2            #x21B3)
  (:L             #x21BA)
  (:L3            #x21BA)
  (:R             #x21BB)
  (:R3            #x21BB)
  (:L-L           #x21BC)
  (:R-L           #x21BD)
  (:L-U           #x21BE)
  (:R-U           #x21BF)
  (:L-R           #x21C0)
  (:R-R           #x21C1)
  (:L-D           #x21C2)
  (:R-D           #x21C3)
  (:L-H           #x21C4)
  (:L-V           #x21C5)
  (:R-H           #x21C6)
  (:A-L           #x21C7)
  (:A-U           #x21C8)
  (:A-R           #x21C9)
  (:A-D           #x21CA)
  (:A-UL          #x21D6)
  (:A-UR          #x21D7)
  (:A-DR          #x21D8)
  (:A-DL          #x21D9)
  (:R-V           #x21F5)
  (:SELECT        #x21F7)
  (:START         #x21F8)
  (:HOME          #x21F9))

(define-glyph-table :keyboard
  (:DEVICE        #x243D)
  (:| |           #x0020)
  (:!             #x0021)
  (:|"|           #x0022)
  (:|#|           #x0023)
  (:$             #x0024)
  (:%             #x0025)
  (:&             #x0026)
  (:|'|           #x0027)
  (:apostrophe    #x0027)
  (:|(|           #x0028)
  (:left-bracket  #x0028)
  (:|)|           #x0029)
  (:right-bracket #x0029)
  (:*             #x002A)
  (:kp-multiply   #x002A)
  (:+             #x002B)
  (:plus          #x002B)
  (:kp-add        #x002B)
  (:|,|           #x002C)
  (:comma         #x002C)
  (:-             #x002D)
  (:minus         #x002D)
  (:kp-subtract   #x002D)
  (:|.|           #x002E)
  (:period        #x002E)
  (:/             #x002F)
  (:slash         #x002F)
  (:kp-divide     #x002F)
  (:|0|           #x0030)
  (:|1|           #x0031)
  (:|2|           #x0032)
  (:|3|           #x0033)
  (:|4|           #x0034)
  (:|5|           #x0035)
  (:|6|           #x0036)
  (:|7|           #x0037)
  (:|8|           #x0038)
  (:|9|           #x0039)
  (:|:|           #x003A)
  (:|;|           #x003B)
  (:semicolon     #x003B)
  (:<             #x003C)
  (:=             #x003D)
  (:kp-equal      #x003D)
  (:equal         #x003D)
  (:>             #x003E)
  (:?             #x003F)
  (:@             #x0040)
  (:A             #x0041)
  (:B             #x0042)
  (:C             #x0043)
  (:D             #x0044)
  (:E             #x0045)
  (:F             #x0046)
  (:G             #x0047)
  (:H             #x0048)
  (:I             #x0049)
  (:J             #x004A)
  (:K             #x004B)
  (:L             #x004C)
  (:M             #x004D)
  (:N             #x004E)
  (:O             #x004F)
  (:P             #x0050)
  (:Q             #x0051)
  (:R             #x0052)
  (:S             #x0053)
  (:T             #x0054)
  (:U             #x0055)
  (:V             #x0056)
  (:W             #x0057)
  (:X             #x0058)
  (:Y             #x0059)
  (:Z             #x005A)
  (:[             #x005B)
  (:|\\|          #x005C)
  (:backslash     #x005C)
  (:]             #x005D)
  (:^             #x005E)
  (:_             #x005F)
  (:|`|           #x0060)
  (:grave-accent  #x0060)
  (:\a            #x0061)
  (:\b            #x0062)
  (:\c            #x0063)
  (:\d            #x0064)
  (:\e            #x0065)
  (:\f            #x0066)
  (:\g            #x0067)
  (:\h            #x0068)
  (:\i            #x0069)
  (:\j            #x006A)
  (:\k            #x006B)
  (:\l            #x006C)
  (:\m            #x006D)
  (:\n            #x006E)
  (:\o            #x006F)
  (:\p            #x0070)
  (:\q            #x0071)
  (:\r            #x0072)
  (:\s            #x0073)
  (:\t            #x0074)
  (:\u            #x0075)
  (:\v            #x0076)
  (:\w            #x0077)
  (:\x            #x0078)
  (:\y            #x0079)
  (:\z            #x007A)
  (:{             #x007B)
  (:|\||          #x007C)
  (:}             #x007D)
  (:~             #x007E)
  (:LEFT          #x2190)
  (:UP            #x2191)
  (:RIGHT         #x2192)
  (:DOWN          #x2193)
  (:CTRL          #x2427)
  (:CONTROL       #x2427)
  (:LEFT-CTRL     #x2427)
  (:LEFT-CONTROL  #x2427)
  (:RIGHT-CTRL    #x2427)
  (:RIGHT-CONTROL #x2427)
  (:ALT           #x2428)
  (:LEFT-ALT      #x2428)
  (:RIGHT-ALT     #x2428)
  (:SHIFT         #x2429)
  (:LEFT-SHIFT    #x2429)
  (:RIGHT-SHIFT   #x2429)
  (:SUPER         #x242A)
  (:TAB           #x242B)
  (:CAPS          #x242C)
  (:CAPS-LOCK     #x242C)
  (:BACKSPACE     #x242D)
  (:ENTER         #x242E)
  (:KP-ENTER      #x242E)
  (:ESC           #x242F)
  (:ESCAPE        #x242F)
  (:PRTSC         #x2430)
  (:PRINT-SCREEN  #x2430)
  (:SCRLK         #x2431)
  (:SCROLL-LOCK   #x2431)
  (:PAUSE         #x2432)
  (:NUMLOCK       #x2433)
  (:NUM-LOCK      #x2433)
  (:INSERT        #x2434)
  (:HOME          #x2435)
  (:PAGEUP        #x2436)
  (:PAGE-UP       #x2436) 
  (:DELETE        #x2437)
  (:END           #x2438)
  (:PAGEDOWN      #x2439)
  (:PAGE-DOWN     #x2439)
  (:SPACE         #x243A)
  (:F1            #x2460)
  (:F2            #x2461)
  (:F3            #x2462)
  (:F4            #x2463)
  (:F5            #x2464)
  (:F6            #x2465)
  (:F7            #x2466)
  (:F8            #x2467)
  (:F9            #x2468)
  (:F10           #x2469)
  (:F11           #x246A)
  (:F12           #x246B))

(define-glyph-table :mouse
  (:DEVICE        #x243D)
  (:LEFT          #x27F5)
  (:RIGHT         #x27F6)
  (:MIDDLE        #x27F7)
  (:SCROLL-U      #x27F0)
  (:SCROLL-D      #x27F1))

(define-glyph-table (:generic-playstation :inherit :gamepad)
  (:X             #x21E0)
  (:Y             #x21E1)
  (:B             #x21E2)
  (:A             #x21E3))

(define-glyph-table (:dualshock-4 :inherit :generic-playstation)
  (:SELECT        #x21E6)
  (:START         #x21E8)
  (:HOME          #x21E7))

(define-glyph-table (:generic-nintendo :inherit :gamepad)
  (:X             #x21A5)
  (:Y             #x21A4)
  (:B             #x21A7)
  (:A             #x21A6)
  (:L1            #x219C)
  (:L2            #x219A)
  (:R1            #x219D)
  (:R2            #x219B))

(define-glyph-table (:nintendo-switch :inherit :generic-nintendo)
  (:SELECT        #x21FD)
  (:START         #x21FE)
  (:HOME          #x21F9))

(define-glyph-table (:generic-xbox :inherit :gamepad)
  (:L1            #x2198)
  (:L2            #x2196)
  (:R1            #x2199)
  (:R2            #x2197)
  (:HOME          #xE001))

(defun degeneralise-axis-symbol (axis threshold)
  (case axis
    (:l-h (if (< 0 threshold) :l-r :l-l))
    (:l-v (if (< 0 threshold) :l-u :l-d))
    (:r-h (if (< 0 threshold) :r-r :r-l))
    (:r-v (if (< 0 threshold) :r-u :r-d))
    (:dpad-h (if (< 0 threshold) :dpad-r :dpad-l))
    (:dpad-v (if (< 0 threshold) :dpad-u :dpad-d))
    (T axis)))

(defun specific-prompt-for-event-trigger (thing &optional (type 'input-event) (default NIL))
  (let ((mapping (first (find-action-mappings thing type))))
    (if mapping
        (let ((symbol (first (qualifier mapping))))
          (or (when (and (eql 'gamepad-move (event-type mapping)) (/= 0.0 (threshold mapping)))
                (degeneralise-axis-symbol symbol (threshold mapping)))
              symbol))
        default)))

(defun specific-prompts-for-event-trigger (thing &optional (type 'input-event))
  (let ((list ()))
    (loop for mapping in (find-action-mappings thing type)
          for threshold = (threshold mapping)
          do (dolist (symbol (qualifier mapping))
               (if (and (eql 'gamepad-move (event-type mapping)) (/= 0.0 (threshold mapping)))
                   (push (degeneralise-axis-symbol symbol (threshold mapping)) list)
                   (push symbol list))))
    list))

(defun normalize-prompt-bank (bank)
  (etypecase bank
    (null
     (normalize-prompt-bank +input-source+))
    (gamepad:device
     (gamepad:icon-type bank))
    (symbol
     bank)))

(defun prompt-string (thing &key bank default)
  (etypecase thing
    (null
     thing)
    (character
     (string thing))
    (string
     thing)
    (integer
     (princ-to-string thing))
    (keyword
     (let ((table (gethash (normalize-prompt-bank bank) *prompt-string-table*)))
       (if table
           (gethash thing table default)
           default)))
    (symbol
     (let* ((type (case bank
                    ((NIL) (etypecase +input-source+
                             ((eql :keyboard) 'key-event)
                             (gamepad:device 'gamepad-event)))
                    (:keyboard 'key-event)
                    (:mouse 'mouse-event)
                    (T 'gamepad-event)))
            (prompt (specific-prompt-for-event-trigger thing type NIL)))
       (cond (prompt
              (let ((char (or (when (eql bank :keyboard)
                                (ignore-errors (local-key-string *context* prompt)))
                              prompt)))
                (prompt-string char :bank bank)))
             (T
              default))))
    (action
     (prompt-string (type-of thing) :bank bank :default default))
    (input-event
     (let* ((prompt (etypecase thing
                      (gamepad-move (degeneralise-axis-symbol (axis thing) (pos thing)))
                      (gamepad-event (button thing))
                      (keyboard-event (key thing))
                      (mouse-button-event (button thing))))
            (bank (or bank
                      (etypecase thing
                        (gamepad-event
                         (if (typep +input-source+ 'gamepad:device)
                             (gamepad:icon-type +input-source+)
                             :gamepad))
                        (key-event :keyboard)
                        (mouse-event :mouse)))))
       (let ((char (or (when (eql bank :keyboard)
                         (ignore-errors (local-key-string *context* prompt)))
                       prompt)))
         (prompt-string char :bank bank :default default))))))

(defun action-strings (thing &key bank)
  (let ((bank (normalize-prompt-bank bank))
        (prompts ()))
    (loop for prompt in (specific-prompts-for-event-trigger thing (case bank
                                                                    (:keyboard 'key-event)
                                                                    (:mouse 'mouse-event)
                                                                    (T 'gamepad-event)))
          for string = (when prompt
                         (or (when (eql bank :keyboard)
                               (ignore-errors (local-key-string *context* prompt)))
                             (prompt-string prompt :bank bank)))
          do (when string (pushnew string prompts)))
    (nreverse prompts)))

(defun action-string (thing &key bank (join " "))
  (with-output-to-string (out)
    (loop for (string . next) on (action-strings thing :bank bank)
          do (write-string string out)
             (when next
               (write-string join out)))))

(defun prompt-charset ()
  (sort (delete-duplicates
         (with-output-to-string (out)
           (loop for bank being the hash-keys of *prompt-string-table* using (hash-value table)
                 do (loop for string being the hash-values of table
                          do (write-string string out)))))
        #'string<))

(define-shader-entity prompt ()
  ())

(defmethod (setf text) ((character character) (prompt prompt))
  (setf (text prompt) (string character)))

(defmethod (setf text) ((symbol symbol) (prompt prompt))
  (setf (text prompt) (prompt-string symbol :default "<unbound>")))

(defmethod (setf prompt-icon) (char (prompt prompt) &key (bank :gamepad))
  (setf (text prompt) (prompt-string char :bank bank)))
