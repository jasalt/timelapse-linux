;; Compare outputted frames next to each other.

;;(chdir "/Users/js/Desktop/chillapse/ep1-july")

(import [os [getcwd chdir listdir makedirs]])
(import [glob [glob]])
(import [moviepy.editor [*]])

(def origin-dir "2-deflickered")

(def frames (glob (+ "./" origin-dir "/*.jpg")))
(print "Found " (len jpgs) "frames.")

(def clip (apply ImageSequenceClip [(list (take 200 frames))] {"fps" 30}))

(apply (. clip write-videofile) ["movie.mp4"] {"threads" 8})

(defmain [&rest args]
  (compare-videos)

  ;; Compose outputs next to each other
  ;; TODO Preview or write
  )
