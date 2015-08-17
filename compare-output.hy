;; Compare outputted frames next to each other.

;;(chdir "/Users/js/Desktop/chillapse/ep1-july")

(import [os [getcwd chdir listdir makedirs]])
(import [glob [glob]])
(import [moviepy.editor [*]])


(defn get-clip [folder]
  "Get clip from given folder's frames."
  (def frames (glob (+  folder "/*.jpg")))
  (print "Found " (len frames) "frames at" folder)
  (apply ImageSequenceClip [(list (take 200 frames))] {"fps" 30}))

(defn compare-videos [&videos]
  ;;(apply (. clip write-videofile) ["movie.mp4"] {"threads" 8})  
  )

(comment
 (def test-a (get-clip "1-jpg-seq"))
 (def test-b (get-clip "2-deflickered"))
 )

(defmain [&rest args]
  (compare-videos)

  ;; Compose outputs next to each other
  ;; TODO Preview or write
  ;; Add texts
  
  ;; TODO
  ;; - Images next to each other / Interleaved
  
  )
