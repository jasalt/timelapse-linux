;; Compare outputted frames next to each other.
;; Partially inspired by https://www.youtube.com/watch?v=aABIlQokIaM

;;(chdir "/Users/js/Desktop/chillapse/ep1-july")

(import [os [getcwd chdir listdir makedirs]])
(import [glob [glob]])
(import [moviepy.editor [*]])
(import [moviepy.video.fx.all [crop]])


(defn get-clip [folder]
  "Get clip from given folder's frames."
  (def frames (glob (+  folder "/*.jpg")))
  (print "Found " (len frames) "frames at" folder)
  (apply ImageSequenceClip [(list (take 200 frames))] {"fps" 30}))

(defn compare-videos [clip-a clip-b]
  "Create a comparison of 2 given clips placed next to each other.
   TODO support multiple"
  (def test-a (get-clip "1-jpg-seq"))
  (def test-b (get-clip "2-deflickered"))

  (let [[half-width (/ (first (. test-a size)) 2)]
        [crop-a (apply crop [test-a] {"x1" 0 "width" half-width})]
        [crop-b (apply crop [test-b] {"x1" half-width "width" half-width})]
        [merged-clip (clips-array [[crop-a crop-b]])]]
    (apply (. merged-clip write-videofile) ["comparison.mp4"] {"fps" 24})))

(defmain [&rest args]
  (compare-videos (nth args 1) (nth args 2))

  ;; Compose outputs next to each other
  ;; TODO Preview or write
  ;; Add texts

  ;; TODO
  ;; - Images next to each other / Interleaved

  )
