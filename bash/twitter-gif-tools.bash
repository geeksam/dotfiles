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
