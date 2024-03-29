(define anthy-hiragana-key '("<Shift>F6" "<Control>caps-lock"))
(define anthy-hiragana-key? (make-key-predicate '("<Shift>F6" "<Control>caps-lock")))
(define anthy-katakana-key '("<Shift>F7" "<Alt>caps-lock"))
(define anthy-katakana-key? (make-key-predicate '("<Shift>F7" "<Alt>caps-lock")))
(define anthy-halfkana-key '("<Shift>F8"))
(define anthy-halfkana-key? (make-key-predicate '("<Shift>F8")))
(define anthy-halfwidth-alnum-key '("<Shift>F10" "<Control>dead-grave"))
(define anthy-halfwidth-alnum-key? (make-key-predicate '("<Shift>F10" "<Control>dead-grave")))
(define anthy-fullwidth-alnum-key '("<Shift>F9"))
(define anthy-fullwidth-alnum-key? (make-key-predicate '("<Shift>F9")))
(define anthy-kana-toggle-key '())
(define anthy-kana-toggle-key? (make-key-predicate '()))
(define anthy-alkana-toggle-key '())
(define anthy-alkana-toggle-key? (make-key-predicate '()))
(define anthy-next-prediction-key '("tab" "down" "<IgnoreCase><Control>n" "<IgnoreCase><Control>i"))
(define anthy-next-prediction-key? (make-key-predicate '("tab" "down" "<IgnoreCase><Control>n" "<IgnoreCase><Control>i")))
(define anthy-prev-prediction-key '(generic-prev-candidate-key))
(define anthy-prev-prediction-key? (make-key-predicate '(generic-prev-candidate-key?)))
