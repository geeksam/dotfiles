# Swiped from https://gist.github.com/brianloveswords/7534169715b5750a892cddcf54c2aa0e
#
# Dependencies
#   ffmpeg
#     macOS: brew install ffmpeg
#     Ubuntu/Debian: apt install ffmpeg
#
# Usage
#   `video-url-from-tweet <url>`    : takes a tweet URL and returns the MP4 embedded in that tweet, or fails if no video is found.
#   `video-from-tweet <url>`        : returns the raw data of the video that is embedded in the tweet
#   `video-to-gif <input> <output>` : converts a video to a GIF
#   `gif-from-tweet <url> <output>` : takes a tweet URL and an output filename and saves the MP4 embedded in that tweet as a GIF.

video-url-from-tweet() {
    if [ "$1" ]; then
        url=$1
    else
        echo "Must provide a url"
        return 1
    fi

    curl --silent $url |\
        # should find the <meta> tag with content="<thumbnail url>"
        (grep -m1 "tweet_video_thumb" ||\
          echo "Could not find video" && return 1) |\

        # from: <meta property="og:image" content="https://pbs.twimg.com/tweet_video_thumb/xxxxxxxxxx.jpg">
        # to: https://pbs.twimg.com/tweet_video_thumb/xxxxxxxxxx.jpg
        cut -d '"' -f 4 |\

        # from: https://pbs.twimg.com/tweet_video_thumb/xxxxxxxxxx.jpg
        # to: https://video.twimg.com/tweet_video/xxxxxxxxxx.mp4
        sed 's/.jpg/.mp4/g' |\
        sed 's/pbs.twimg.com\/tweet_video_thumb/video.twimg.com\/tweet_video/g'
}
video-from-tweet() {
    if [ "$1" ]; then
        url=$1
    else
        echo "Must provide a url"
        return 1
    fi
    curl $(video-url-from-tweet $url)
}
video-to-gif() {
    # derived from https://engineering.giphy.com/how-to-make-gifs-with-ffmpeg/
    if [ "$2" ]; then
        input=$1
        output=$2
    else
        echo "Must provide an input file and output file"
        return 1
    fi

    ffmpeg -i $input \
           -filter_complex "[0:v] split [a][b];[a] palettegen [p];[b][p] paletteuse" \
           -f gif \
           $output
}
gif-from-tweet() {
    if [ "$2" ]; then
        url=$1
        output=$2
    else
        echo "Must provide a url and an output filename"
        return 1
    fi
    video-from-tweet $url | video-to-gif - $output
}
